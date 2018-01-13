From: dave.hansen@linux.intel.com (Dave Hansen)
Date: Fri, 12 Jan 2018 17:19:32 -0800
Subject: [PATCH] security/Kconfig: Replace pagetable-isolation.txt
	reference with pti.txt
In-Reply-To: <3009cc8ccbddcd897ec1e0cb6dda524929de0d14.1515799398.git.wking@tremily.us>
References: <9b21ce8f-625c-6915-654b-42334cf38e99@linux.intel.com>
	<3009cc8ccbddcd897ec1e0cb6dda524929de0d14.1515799398.git.wking@tremily.us>
Message-ID: <68769b20-2be5-85b7-f21c-cc9094de547c@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/12/2018 03:24 PM, W. Trevor King wrote:
> The reference landed with the config option in 385ce0ea (x86/mm/pti:
> Add Kconfig, 2017-12-04), but the referenced file was not committed
> then.  It eventually landed in 01c9b17b (x86/Documentation: Add PTI
> description, 2018-01-05) as pti.txt.
> 
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> On Fri, Jan 12, 2018 at 03:10:53PM -0800, Dave Hansen wrote:
>> There is a new file in -tip:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/pti&id=01c9b17bf673b05bb401b76ec763e9730ccf1376
>>
>> If you're going to patch this, please send an update to -tip that
>> corrects the filename.
> 
> Here you go :).

Feel free to add my Acked-by.  And please send to x86 at kernel.org.  They
need to put this in after the addition of the documentation.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
