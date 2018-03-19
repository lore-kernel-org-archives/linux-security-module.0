From: mtownsend1973@gmail.com (Martin Townsend)
Date: Mon, 19 Mar 2018 14:37:26 +0000
Subject: Problem mounting pseudo filesystems with SMACK and IMA enabled.
In-Reply-To: <CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
	<1521206743.3503.29.camel@linux.vnet.ibm.com>
	<CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
	<1521211762.3503.46.camel@linux.vnet.ibm.com>
	<77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
	<CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
Message-ID: <CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 17, 2018 at 9:20 AM, Martin Townsend
<mtownsend1973@gmail.com> wrote:
> Hi Casey,
>
> On Fri, Mar 16, 2018 at 3:52 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/16/2018 7:49 AM, Mimi Zohar wrote:
>>> On Fri, 2018-03-16 at 14:34 +0000, Martin Townsend wrote:
>>>> Hi Mimi,
>>>>
>>>> On Fri, Mar 16, 2018 at 1:25 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>>>> On Fri, 2018-03-16 at 09:32 +0000, Martin Townsend wrote:
>>>>>> [Resending to new integrity mailing list]
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I have a system with a pre-signed UBI root filesystem image with both
>>>>>> IMA/EVM signatures on all files.  The Root CA Cert is compiled into
>>>>>> the kernel and the public keys is in the rootfs.  All SMACK labels
>>>>>> have also been applied although at this early stage there aren't many
>>>>>> (just a few application specific ones) so it's mainly the defaults.
>>
>> If you can apply a label to all of the files on the filesystem
>> ( find $FSROOT -exec chsmack -a "_" {} \; ) and then set the
>> specific file labels you want you will ensure that you won't
>> go through the label defaulting mechanism. I don't think that
>> is your problem, but it's worth a try.
>>
> I tried this but no joy.
>
>>>>>> This image is then flashed to the on board NAND.
>>>>>>
>>>>>> The kernel bootargs for IMA are
>>>>>>
>>>>>> "ima_audit=1 ima_template=ima-ng ima_hash=sha1 ima_tcb
>>>>>> ima_appraise_tcb rootflags=i_version"
>>>>>>
>>>>>> and I'm enabling SMACK by using the kernel bootarg
>>>>>>
>>>>>> "security=smack"
>>>>>>
>>>>>> now if I boot without the "security=smack" it boots fine and I can
>>>>>> check the IMA/EVM signatures and can see that measurements are being
>>>>>> taken, but if I enable SMACK using the above kernel bootarg it fails
>>>>>> to boot and it looks like some problem early in systemd where it
>>>>>> mounts the required filesystems in mount-setup.c (log provided below).
>>>>>> Now if I flash an image that hasn't been signed and enable SMACK it
>>>>>> boots fine and I can use SMACK to enforce access control.  So there
>>>>>> seems to some interaction between the two when mounting the early
>>>>>> filesystems.
>>>>>>
>>>>>> Before I delve into this I would appreciate any pointers to where to
>>>>>> start looking, any printk's to put in SMACK/IMA/mount code to help
>>>>>> diagnose this would be really appreciated.
>>>>>>
>>>>>> The Kernel is 4.9 LTSI, systemd is v229
>>
>> Are you using a base distribution? Fedora, Ubuntu, Debian, Alpine?
>> That information may make the issue easier to reproduce.
>
> It's a linux-yocto distribution for an i.MX6UL board. I'm trying to
> get QEMU working to make it easier to debug and reproduce but alas
> this may prove harder to achieve than debugging this issue with
> printk's
>
>>
>>>>>>
>>>>>> Apologies if I have the wrong mailing list for SMACK, I couldn't find
>>>>>> one on vger.kernel.org.
>>
>> SMACK-discuss at lists.01.org is the most Smack directed list.
>> linux-security-module at vger.kernel.org is the "official" place.
>> casey at schaufler-ca.com is me directly.
>
> Thank you I will use these in future.
>>
>>>>>>
>>>>>>
>>>>>> Boot log.
>>>>>> ...
>>>>>> Security Framework initialized
>>>>>> Smack:  Initializing.
>>>>>> Smack:  IPv6 port labeling enabled.
>>>>>> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>>>>>> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>>>>>> CPU: Testing write buffer coherency: ok
>>>>>> Setting up static identity map for 0x80100000 - 0x80100058
>>>>>> devtmpfs: initialized
>>>>>> evm: security.SMACK64
>>>>>> evm: security.SMACK64EXEC
>>>>>> evm: security.SMACK64TRANSMUTE
>>>>>> evm: security.SMACK64MMAP
>>>>>> evm: security.ima
>>>>>> evm: security.capability
>>>>>> ...
>>>>>> Loading compiled-in X.509 certificates
>>>>>> Loaded X.509 cert 'IMA-EVM Root CA: cc972d25acf7c1efaa5329a48104efa303f0833a'
>>>>>> ...
>>>>>> UBIFS (ubi0:0): FS size: 201764864 bytes (192 MiB, 1589 LEBs), journal
>>>>>> size 9023488 bytes (8 MiB, 72 LEBs)
>>>>>> UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
>>>>>> UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID
>>>>>> F6EA70A5-1931-4049-89CB-93B82F37F6A4, small LPT model
>>>>>> VFS: Mounted root (ubifs filesystem) readonly on device 0:16.
>>>>>> devtmpfs: mounted
>>>>>> integrity: Loaded X.509 cert 'IMA Certificate Authority:
>>>>>> e2c191a6e31fd02d6beba0c7c7847720a35fd9c6': /etc/keys/ima-x509.der
>>>>>> Freeing unused kernel memory: 1024K
>>>>>> systemd[1]: Successfully loaded Smack policies.
>>
>> Is your list of Smack rules large? What is it based on?
>
> At the moment there are 2 rules :)  It's not based on anything, the
> next step is to start creating rules for the system but I don't
> envisage that there will be many.
>
>>
>>>>>> systemd[1]: Successfully loaded Smack/CIPSO policies.
>>>>>> systemd[1]: System time before build time, advancing clock.
>>>>>> systemd[1]: Failed to mount tmpfs at /dev/shm: No such file or directory
>>>>>> systemd[1]: Failed to mount tmpfs at /dev/shm: No such file or directory
>>>>>> systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/systemd: No such
>>>>>> file or directory
>>
>> This is where the audit trail could be very helpful. It can tell us
>> what action failed.
>
> I thought I found the problem.  systemd was changing the SMACK label
> on /dev to '*' and I had put IMA/EVM signature on /dev in the rootfs
> so I was thinking the new SMACK label would break IMA/EVM for the dev
> folder and as the first message were about /dev/shm not being found I
> thought this was it.  But after removing the IMA/EVM signing of
> directories, labelling /dev with '*' during the image signing and even
> replacing all calls to lsetxattr in systemd with a log message the
> problem still exists.
>
> I put a printk at the end of common_lsm_audit and it never appeared so
> I'm assuming there are no audit messages.  I put a prink on
> process_measurements in IMA and it always returned 0 except for one
> place where systemd was trying to load rules into load2
>
> process_measurement: process_measurement: [smackfs magic:43415d53] /load2
> process_measurements: ret -EACCESS rc:4
>
> Not sure this is the problem though as there are 2 rules which are
> application specific.  I load them later anyway with a systemd
> service.  Put a printk on various SMACK functions including
> smack_sb_kern_mount and they all return 0.
>
> It looks like this is something particular to my system so I don't
> want to take anymore of your time unless I find something that tells
> me otherwise.  I'm going to start by investigating what's special
> about mounting /dev/shm and /sys/fs/cgroup/systemd as these are the
> two that are failing, it seems to mounting other things by looking at
> the systemd mount table.
>
> If anyone can suggest a good place to start looking that would be
> appreciated otherwise I'll start with mounting code and shm code.
>
>>
>>>>>> [!!!!!!] Failed to mount API filesystems, freezing.
>>>>>> systemd[1]: Freezing execution.
>>>>> [Cc'ing Sascha]
>>>>>
>>>>> Are there any additional messages in /var/log/audit/audit.log?
>>>>>
>>>>> Mimi
>>>>>
>>>> Sadly I can't see this file, I don't even think the relevant
>>>> filesystems have been mounted as this point. I tried the emergency
>>>> shell but no joy. Is there a way of patching the kernel to show audit
>>>> messages to the console?  If you point me at the relevant code I'll
>>>> hack something in.  I'm currently putting printk's everywhere I can
>>>> think of to see what's going on.   If you can think of anywhere in the
>>>> IMA that would be good to see a debug print let me know, currently I
>>>> have something in process_measurements and a few other places in
>>>> ima_main.c.
>>> I would think the audit messages would go to the console.  With
>>> dracut, I use a couple of boot command line options for debugging (eg.
>>> rd.debug rd.break=pre-mount, rd.shell).
>>>
>>> Mimi
>>>
>>>
>>

The problem was because systemd couldn't create directories for the
mounts /dev/shm and /sys/fs/cgroup/systemd, it was returning -ENOKEY.
After investigating it looks like I need to set a key for HMAC to stop
the mkdir failing which I didn't appreciate I needed with a pre-signed
image.

I have a question on this, looking at the IMA code it will try and
replace my signatures with the HMAC unless the immutable attribute is
set, is this correct?  In the evmctl utility there's mention of an evm
immutable flag but I see nothing in the kernel code that supports
this. Is this a feature that never made it into the kernel? or is it
there but I've missed it?

Second question, I have no TPM module so do I need to add a key for
HMAC or is there another way? It's not a problem if I have to add a
key I just want to make 100% sure I have to before patching systemd or
creating my own init process that adds the key before handing over to
systemd.

Many Thanks, Martin.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
