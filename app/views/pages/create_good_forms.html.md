# How to create a good form using GOV.UK Forms

## Making sure a form is accessible

It's important that government forms are accessible to everyone, including disabled people using assistive technologies.

When you create a form with GOV.UK Forms, you're using designs which have been tested to make sure they meet government accessibility standards. But it's still possible to create accessibility problems if you use GOV.UK Forms incorrectly.

### Asking questions in an accessible way

When you create a form, you'll be asked what kind of answer you need for each question. Make sure you choose the right option: that way the browser knows what kind of answer to expect, and can help the user by filling in parts of the form automatically.

Avoid asking for the same information more than once within a form.

Use language that everyone who needs to complete the form will understand. Explain anything that's not obvious - for example, by adding hint text or guidance to a question.

### Accessible links and headings

Use link text which tells the user what will happen if they follow the link, even if they're reading it out of context. For example, 'Find out more about GOV.UK Forms'. Avoid link text that does not make sense out of context - like 'Click here' or 'Read more'.

Disabled users often rely on headings to help them navigate around a website page. So if you add a heading to a page in your form, make sure the heading reflects what's underneath it. For example, to break up text that's aimed at two different audiences, create two headings. Then put the text that's aimed at each audience under the relevant heading - avoid 'orphaning' any text so it falls under the wrong heading.

## Linking to a form from the GOV.UK website

You'll need a link to your form from the GOV.UK website so that people can find it.

The GOV.UK publishing team in your organisation will be able to advise on whether GOV.UK Forms is the best way to meet your needs - and how to link to the form. Talk to them about your requirements as soon as possible.

### If you're in a GOV.UK publishing team

It's possible to add a link from an existing 'publication:form' page, but where possible we recommend linking to the form from a service-style starting point.

You can create a starting point using the 'detailed guide' format in Whitehall publisher. [DVSA's 'Close your MOT centre' page](https://www.gov.uk/guidance/close-your-mot-centre/) is an example.

Use Markdown to create a green 'Start now' button:

```markdown
{button start}[Button text goes here](https://submit.forms.service.gov.uk/form/first-page-of-form){/button}
```

If there's a paper version of the form, you can add it as an attachment to the same detailed guide page - then unpublish and redirect the old 'publication:form' page. That way you can avoid having more than one page meeting the same user need.

## Useful links

- [Structuring forms](https://www.gov.uk/service-manual/design/form-structure)
- [Writing for user interfaces](https://www.gov.uk/service-manual/design/writing-for-user-interfaces)
- [Creating a starting point on the GOV.UK website](https://design-system.service.gov.uk/patterns/start-using-a-service/)
- [Writing a privacy notice](https://www.gov.uk/service-manual/design/collecting-personal-information-from-users#tell-users-what-information-youre-collecting-and-what-youll-do-with-it)
- [How to check the quality of your form if you're in a hurry](https://www.effortmark.co.uk/look-form-hurry/)
