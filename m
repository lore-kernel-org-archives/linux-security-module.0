From: kent.overstreet@gmail.com (Kent Overstreet)
Date: Wed, 23 May 2018 18:06:26 -0400
Subject: [PATCH 6/6] Drop flex_arrays
In-Reply-To: <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-6-kent.overstreet@gmail.com>
	<0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
Message-ID: <20180523220626.GA23040@kmo-pixel>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 23, 2018 at 10:24:18AM -0700, Dave Hansen wrote:
> Thanks for the heads-up, Matthew!

Sorry, I was just using scripts/get_maintainers, forgot to check the actual file
for the original author :)

> On 05/22/2018 06:18 PM, Kent Overstreet wrote:
> > All existing users have been converted to generic radix trees
> 
> Well, flex_arrays had a good run, and the new radix trees do look quite
> a bit nicer.
> 
> Feel free to add my ack.

Cool, thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
