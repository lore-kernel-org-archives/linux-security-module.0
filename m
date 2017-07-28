From: guilherme.magalhaes@hpe.com (Magalhaes, Guilherme (Brazil R&D-CL))
Date: Fri, 28 Jul 2017 14:19:59 +0000
Subject: [Linux-ima-devel] [RFC PATCH 1/5] ima: extend clone() with IMA
	namespace support
In-Reply-To: <1501166369.28419.171.camel@linux.vnet.ibm.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
	<20170725175317.GA727@mail.hallyn.com>
	<1501008554.3689.30.camel@HansenPartnership.com>
	<20170725190406.GA1883@mail.hallyn.com>
	<1501009739.3689.33.camel@HansenPartnership.com>
	<1501012082.27413.17.camel@linux.vnet.ibm.com>
	<645db815-7773-e351-5db7-89f38cd88c3d@linux.vnet.ibm.com>
	<20170725204622.GA4969@mail.hallyn.com>
	<1501016277.27413.50.camel@linux.vnet.ibm.com>
	<20170725210801.GA5628@mail.hallyn.com>
	<1501018134.27413.66.camel@linux.vnet.ibm.com>
	<TU4PR84MB03021F7FDF1B89ECAA8F7FFFFFBE0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
	<1501166369.28419.171.camel@linux.vnet.ibm.com>
Message-ID: <TU4PR84MB03025BC4B8DEC44A0D63A298FFBF0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> > Each measurement entry in the list could have new fields to identify
> > the namespace. Since the namespaces can be reused, a timestamp or
> > others fields could be added to uniquely identify the namespace id.
> 
> The more fields included in the measurement list, the more
> measurements will be added to the measurement list.  Wouldn't it be
> enough to know that a certain file has been accessed/executed on the
> system and base any analytics/forensics on the IMA-audit data.

With the recursive application of policy through the namespace hierarchy,
a measurement added to the parent namespace could be misleading since 
the file pathname makes sense in the current namespace but possibly not
for the parent namespace. This is the reason why I believe some new field
might be needed in the IMA template format to indicate or uniquely 
identify the namespace.

--
Guilherme

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
