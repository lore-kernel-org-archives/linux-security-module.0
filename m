From: peterhuewe@gmx.de (Peter Huewe)
Date: Wed, 30 Aug 2017 12:41:51 +0200
Subject: [tpmdd-devel] [PATCH RESEND 3/3] tpm-chip: Export TPM device to
	user space even when startup failed
In-Reply-To: <20170830101510.rlkh2p3zecfsrhgl@linux.intel.com>
References: <20170824083714.10016-1-Alexander.Steffen@infineon.com>
	<20170824083714.10016-4-Alexander.Steffen@infineon.com>
	<20170825172021.lw3ycxqw63ubrcm2@linux.intel.com>
	<adaaeae32ba64d979abfc4b758c63fc0@MUCSE603.infineon.com>
	<20170829125509.55aylht3ikes3bpy@linux.intel.com>
	<20170829151739.315ae581@kitsune.suse.cz>
	<20170830101510.rlkh2p3zecfsrhgl@linux.intel.com>
Message-ID: <4722067A-082C-40E7-90ED-29EFB3228765@gmx.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



Am 30. August 2017 12:15:10 MESZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
>On Tue, Aug 29, 2017 at 03:17:39PM +0200, Michal Such?nek wrote:
>> Hello,
>> 
>> On Tue, 29 Aug 2017 15:55:09 +0300
>> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>> 
>> > On Mon, Aug 28, 2017 at 05:15:58PM +0000,
>> > Alexander.Steffen at infineon.com wrote:
>> > > But is that just because nobody bothered to implement the
>necessary
>> > > logic or for some other reason?  
>> > 
>> > We do not want user space to access broken hardware. It's a huge
>risk
>> > for system stability and potentially could be used for evil
>purposes.
>> > 
>> > This is not going to mainline as it is not suitable for general
>> > consumption. You must use a patched kernel if you want this.
>> > 
>> > /Jarkko
>> > 
>> 
>> It has been pointed out that userspace applications that use direct
>IO
>> access exist for the purpose. So using a kernel driver is an
>> improvement over that if the interface is otherwise sane.
>> 
>> What do you expect is the potential for instability or evil use?
>
>By definition the use of broken hardware can have unpredictable
>effects.
>Use a patched kernel if you want to do it.

If the s.m.a.r.t selftest of your hard disk fails, you can still access it, even though the hw selftest says it is broken.
Same situation.



>
>/Jarkko
>
>------------------------------------------------------------------------------
>Check out the vibrant tech community on one of the world's most
>engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>_______________________________________________
>tpmdd-devel mailing list
>tpmdd-devel at lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/tpmdd-devel

-- 
Sent from my mobile
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
