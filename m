From: dave.hansen@linux.intel.com (Dave Hansen)
Date: Fri, 12 Jan 2018 15:10:53 -0800
Subject: [PATCH] security/Kconfig: Remove pagetable-isolation.txt reference
In-Reply-To: <alpine.LFD.2.20.1801131006520.13286@localhost>
References: <0ccf9a4d2e42bcb823ab877e4fb21274f27878bd.1515794059.git.wking@tremily.us>
	<alpine.LFD.2.20.1801131006520.13286@localhost>
Message-ID: <9b21ce8f-625c-6915-654b-42334cf38e99@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/12/2018 03:06 PM, James Morris wrote:
> On Fri, 12 Jan 2018, W. Trevor King wrote:
> 
>> The reference landed with the config option in 385ce0ea (x86/mm/pti:
>> Add Kconfig, 2017-12-04), but the referenced file was never committed.
>>
>> Signed-off-by: W. Trevor King <wking@tremily.us>
> 
> Acked-by: James Morris <james.l.morris@oracle.com>

There is a new file in -tip:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/pti&id=01c9b17bf673b05bb401b76ec763e9730ccf1376

If you're going to patch this, please send an update to -tip that corrects the filename.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
