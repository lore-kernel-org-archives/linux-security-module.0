From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 16 Nov 2017 14:35:22 -0500
Subject: [PATCH 0/4] treewide: Fix line continuation formats
In-Reply-To: <1510852649.31559.38.camel@perches.com>
References: <cover.1510845910.git.joe@perches.com>
	<1510852273.3711.448.camel@linux.vnet.ibm.com>
	<1510852649.31559.38.camel@perches.com>
Message-ID: <1510860922.3711.452.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-11-16 at 09:17 -0800, Joe Perches wrote:
> On Thu, 2017-11-16 at 12:11 -0500, Mimi Zohar wrote:
> > On Thu, 2017-11-16 at 07:27 -0800, Joe Perches wrote:
> > > Avoid using line continations in formats as that causes unexpected
> > > output.
> > 
> > Is having lines greater than 80 characters the preferred method?
> 
> yes.
> 
> >  Could you add quotes before the backlash and before the first word on
> > the next line instead?
> 
> coalesced formats are preferred.

In the future, please reference the commit 6f76b6fcaa60 "CodingStyle:
Document the exception of not splitting user-visible strings, for
grepping"

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
