// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

/*!
 * Color mode toggler for Bootstrap's docs (https://getbootstrap.com/)
 * Copyright 2011-2023 The Bootstrap Authors
 * Licensed under the Creative Commons Attribution 3.0 Unported License.
 */

// https://getbootstrap.com/docs/5.3/customize/color-modes/

(() => {
	'use strict'
  
	const getPreferredTheme = () => {
	  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
	}
  
	const setTheme = theme => {
	  if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
		document.documentElement.setAttribute('data-bs-theme', 'dark')
	  } else {
		document.documentElement.setAttribute('data-bs-theme', theme)
	  }
	}
  
	setTheme(getPreferredTheme())
  
  })()
