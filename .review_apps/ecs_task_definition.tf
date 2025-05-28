locals {
  logs_stream_prefix = "${data.terraform_remote_state.review.outputs.review_apps_log_group_name}/forms-product-page/pr-${var.pull_request_number}"

  review_app_hostname = "pr-${var.pull_request_number}.www.review.forms.service.gov.uk"

  forms_product_page_env_vars = [
    { name = "RACK_ENV", value = "production" },
    { name = "RAILS_ENV", value = "production" },
    { name = "SETTINGS__FORMS_ENV", value = "review" },
  ]
}

resource "aws_ecs_task_definition" "task" {
  family = "forms-product-page-pr-${var.pull_request_number}"

  network_mode = "awsvpc"
  cpu          = 256
  memory       = 1024

  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  execution_role_arn = data.terraform_remote_state.review.outputs.ecs_task_execution_role_arn

  container_definitions = jsonencode([

    # forms-product-page
    {
      name                   = "forms-product-page"
      image                  = var.forms_product_page_container_image
      command                = []
      essential              = true
      environment            = local.forms_product_page_env_vars
      readonlyRootFilesystem = true

      dockerLabels = {
        "traefik.http.middlewares.forms-product-page-pr-${var.pull_request_number}.basicauth.users" : data.terraform_remote_state.review.outputs.traefik_basic_auth_credentials

        "traefik.http.routers.forms-product-page-pr-${var.pull_request_number}.rule" : "Host(`${local.review_app_hostname}`)",
        "traefik.http.routers.forms-product-page-pr-${var.pull_request_number}.service" : "forms-product-page-pr-${var.pull_request_number}",
        "traefik.http.routers.forms-product-page-pr-${var.pull_request_number}.middlewares" : "forms-product-page-pr-${var.pull_request_number}@ecs"

        "traefik.http.services.forms-product-page-pr-${var.pull_request_number}.loadbalancer.server.port" : "3000",
        "traefik.http.services.forms-product-page-pr-${var.pull_request_number}.loadbalancer.healthcheck.path" : "/up",
        "traefik.enable" : "true",
      },

      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = data.terraform_remote_state.review.outputs.review_apps_log_group_name
          awslogs-region        = "eu-west-2"
          awslogs-stream-prefix = "${local.logs_stream_prefix}/forms-product-page"
        }
      }

      healthCheck = {
        command     = ["CMD-SHELL", "wget -O - 'http://localhost:3000/up' || exit 1"]
        interval    = 30
        retries     = 5
        startPeriod = 180
      }
    }
  ])
}
