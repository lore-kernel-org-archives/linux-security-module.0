From: dave.hansen@intel.com (Dave Hansen)
Date: Wed, 23 May 2018 10:24:18 -0700
Subject: [PATCH 6/6] Drop flex_arrays
In-Reply-To: <20180523011821.12165-6-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-6-kent.overstreet@gmail.com>
Message-ID: <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thanks for the heads-up, Matthew!

On 05/22/2018 06:18 PM, Kent Overstreet wrote:
> All existing users have been converted to generic radix trees

Well, flex_arrays had a good run, and the new radix trees do look quite
a bit nicer.

Feel free to add my ack.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
