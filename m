From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Mon, 20 Mar 2017 09:54:41 +0000
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <bca2bee3c1b84100ac72238425ac4791@MUCSE612.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
	<20170317161614.GA28082@obsidianresearch.com>
	<bca2bee3c1b84100ac72238425ac4791@MUCSE612.infineon.com>
Message-ID: <12e63cdba1e34cac9b82e4bff9621ae6@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

>>> 2. When upgrading the firmware on my TPM, it switches to a
>>> non-standard communication mode for the upgrade process and does not
>>> communicate using TPM2.0 commands during this time. Rejecting
>>> non-TPM2.0 commands means upgrading won't be possible anymore.
>>
>> How non standard? Is the basic header even there? Are the lengths and
>> status code right?
>>
>> This might be an argument to add a 'raw' ioctl or something specifically
>> for this special case.
>
> It follows the regular TPM command syntax and looks something like 1.2
> commands.

Yep, so most of it already works with the current implementation.

There are a few special cases that need some thought though. For example, it is possible to use an upgrade to switch the TPM family from 1.2 to 2.0 (or vice versa). In this case it seems useful to let the kernel reinitialize the TPM driver, so it uses the correct timeouts for communication, activates the correct features (resource manager or not?), etc., without needing to reboot the system.

Another problem arises when the upgrade process is interrupted, e.g. because power is lost. Then the TPM is stuck in its non-standard upgrade mode, so the kernel does not recognize it as a valid TPM device and does not export /dev/tpm<n>. But without the device node the upgrader is unable to restart the upgrade process, leaving the TPM forever inaccessible.

I'll try to work on those problems in the coming weeks and provide the fixes. Any input is appreciated.

Alexander
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
