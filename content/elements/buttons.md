---
title: Buttons
layout: docs
description: Buttons trigger interactions throughout the experience.
group: elements
toc: true
sizes:
- xs
- sm
- lg
- xl
---

## Base

Buttons make common actions immediately visible and easy to perform with one click or tap. They can be used for any type of action, including navigation.

{% capture btn %}
<button type="button" class="c-btn c-btn-primary">Button</button>
{% endcapture %}

{% include example.html content=btn %}

## Color Examples

This is an example of available colors for the **{{ page.title }}** element. 

{% capture btnColors %}
{% for color in site.data.theme-colors %}
<button type="button" class="c-btn c-btn-{{ color }}">{{ color | capitalize }}</button>{% endfor %}
{% endcapture %}

{% include example.html content=btnColors %}


## Size Examples

This is an example of available sizes for the **{{ page.title }}** element. 

{% capture btnSizes %}
{% for size in site.data.theme-sizes %}
<button type="button" class="c-btn c-btn-primary c-btn-{{ size.value }}">{{ size.name }}</button>{% endfor %}
{% endcapture %}

{% include example.html content=btnSizes %}


## Disabled state

Make buttons look inactive by adding the `disabled` boolean attribute to any `<button>` element.

{% example html %}
{% for color in site.data.theme-colors %}
<button type="button" class="c-btn c-btn-{{ color }}" disabled>{{ color | capitalize }}</button>{% endfor %}
{% endexample %}

## Additional Styles & Options

This modifiers can be mixed/matched as needed

### Outlines
{% example html %}
{% for color in site.data.theme-colors %}
<button type="button" class="c-btn c-btn-{{ color }}-outline">{{ color | capitalize }}</button>{% endfor %}
{% endexample %}

### Pills and Colors
{% example html %}
{% for color in site.data.theme-colors %}
<button type="button" class="c-btn c-btn-{{ color }} c-btn-pill">{{ color | capitalize }}</button>{% endfor %}
{% endexample %}


### Block Button
{% example html %}
<button type="button" class="c-btn c-btn-primary c-btn-lg c-btn-block">Block level button</button>
{% endexample %}