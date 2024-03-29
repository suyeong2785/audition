// 범용성 있는 자바스크립트
String.prototype.replaceAll = function(org, dest) {
	return this.split(org).join(dest);
}

function getUriParams(uri) {
	uri = uri.trim();
	uri = uri.replaceAll('&amp;', '&');
	if (uri.indexOf('#') !== -1) {
		var pos = uri.indexOf('#');
		uri = uri.substr(0, pos);
	}

	var params = {};

	uri.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) {
		params[key] = value;
	});
	return params;
}

function jq_attr($el, attrName, elseValue) {
	var value = $el.attr(attrName);

	if (value === undefined || value === "") {
		return elseValue;
	}

	return value;
}

function isCellphoneNo(str) {
	if (str.substr(0, 1) != '0') {
		return false;
	}

	return isNumber(str);
}

function isNumber(n) {
	return /^-?[\d.]+(?:e-?\d+)?$/.test(n);
}

function getHtmlEncoded(raw) {
	return raw.replace(/[\u00A0-\u9999<>\&]/gim, function(i) {
		return '&#' + i.charCodeAt(0) + ';';
	});
}

function iOS() {
	return [ 'iPad Simulator', 'iPhone Simulator', 'iPod Simulator', 'iPad', 'iPhone', 'iPod' ].includes(navigator.platform)
	// iPad on iOS 13 detection
	|| (navigator.userAgent.includes("Mac") && "ontouchend" in document)
}


function formatDate(datetime) {
    let date = new Date(datetime);
    let formatted_date = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
    return formatted_date;
}