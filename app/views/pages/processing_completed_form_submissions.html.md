# Processing completed form submissions

GOV.UK Forms sends submissions to you one at a time, as they come in.

By default, submissions are sent by email - from no-reply@forms.service.gov.uk
to the email address you nominate when creating the form. Any files you ask the user to upload are attached to the email.

Each submission is given a unique reference. The unique reference is included in the subject line and the body of the email.

Submission email subject lines use this format:

```markdown
Form submission: Form name - reference: 8E3YY3RX
```

The body of the email includes each of the questions asked in the form, followed by the answer the user has given for that question.

## Automatically forward email submissions to a different mailbox

When you create a form in GOV.UK Forms, you’re required to specify a single email address to send submissions to.

If you need to route submissions to different email addresses based on an answer provided in the form, you may be able to configure your organisation’s email client so it does that for you. 

For example, MS Outlook allows you to [set up forwarding rules based on whether the email includes a specific keyword](https://support.microsoft.com/en-gb/office/use-rules-to-automatically-forward-messages-45aa9664-4911-4f96-9663-ece42816d746).

Bear in mind that MS Outlook forwarding rules will pick up any use of a keyword in the submission email - so MS Outlook could forward an email to the wrong place if a person uses the keyword in a way you do not expect. This is less of an issue with questions where you’re asking users to choose options from a list, because you can predict what text will appear in the submission email.

## Get form submissions as JSON or CSV email attachments

If you’re planning to automate your form processing using a low code platform like MS Power Automate or Google Apps Script, it may be easier to work with submission data in JSON or CSV format.

When you create or edit a form, you can opt to get submission data attached to the emails as a JSON or CSV file - as well as in the body of the email. Send yourself test submissions so you can see how emails are laid out and help set up your automation. You can view the [JSON schema for form submissions](https://www.forms.service.gov.uk/json-submissions/v1/schema).

### Automate processing of email submissions

If you’re not sure whether your organisation supports use of a low code platform - or you need help setting up an automation - contact your organisation’s digital or IT team. Some organisations have a team which specialises in low code automation.

If your organisation supports MS Power Automate, the Microsoft website has [guidance on getting started with MS Power Automate](https://learn.microsoft.com/en-us/power-automate/flow-types). Or the Google website has [guidance on getting started with automations in Google Apps Script](https://developers.google.com/apps-script/quickstart/automation).

You can also [join the cross-government low code community](https://www.gov.uk/service-manual/communities/low-code-community).

## Receive form submissions in an AWS S3 bucket

If your organisation has access to the AWS stack, you can opt to receive form submissions in an AWS S3 bucket instead of by email. Submissions are written to the S3 bucket as individual JSON or CSV files.


If you want to receive form submission in an AWS S3 bucket, [send us a support request](https://www.forms.service.gov.uk/support) confirming that you:

* have a technical team with access to the AWS stack, who can set up and maintain an S3 bucket on your behalf
* intend to configure the S3 bucket following relevant NCSC guidance (in particular the [cloud security guidance](https://www.ncsc.gov.uk/collection/cloud/using-cloud-services-securely/using-a-cloud-platform-securely) and [advice on configuring S3 buckets securely](https://www.ncsc.gov.uk/blog-post/theres-hole-my-bucket)

Once you’ve raised the ticket, we’ll respond with the permissions you need to give us to start writing data to your S3 bucket.
