/*! @gov.au/footer v0.3.0 */
/***************************************************************************************************************************************************************
 *
 * footer function
 *
 * Footers help users who reach the bottom of a page without finding what they want.
 *
 **************************************************************************************************************************************************************/

import React from 'react';
import PropTypes from 'prop-types';


// The following line will be replaced automatically with generic imports for the ES5 pipeline.
// You can safely ignore this bit if you use this module with pancake
//
// [replace-imports]

/**
 * A section for the footer that contains navigational elements
 *
 * @param  {node} children - The inside of this section
 */
export const FooterNav = ({ children }) => (
	<nav className="uikit-footer__navigation">
		{ children }
	</nav>
);

FooterNav.propTypes = {
	children: PropTypes.node.isRequired,
};


/**
 * A section for the footer that sits at the end
 *
 * @param  {node} children - The inside of this section
 */
export const FooterEnd = ({ children }) => (
	<nav className="uikit-footer__end">
		{ children }
	</nav>
);

FooterEnd.propTypes = {
	children: PropTypes.node.isRequired,
};


/**
 * DEFAULT
 * The footer component
 *
 * @param  {node} children - The inside of this section
 */
const Footer = ({ children }) => (
	<footer className="uikit-footer" role="contentinfo">
		{ children }
	</footer>
);

Footer.propTypes = {
	children: PropTypes.node.isRequired,
};

export default Footer;
