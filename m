Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fIgMHMiO"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EA1A4
	for <linux-security-module@vger.kernel.org>; Tue,  5 Dec 2023 11:55:19 -0800 (PST)
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 79FB53F6B6;
	Tue,  5 Dec 2023 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701806117;
	bh=UXcZJKhM+jIAgtM7997vYh0ODVGsg8UkAAvj405z7pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=fIgMHMiO3TxnRZuk6SRjGKlQa4ZOYp6l6dInaevDfJO7VPwTVlphW2ijXrzD4lsOX
	 xB95SEigCPq8tRmlZ3TpHXb2bHxLZbsLl0RgcIEwriImcIkRlJ1hXO6ArnkOapHLt4
	 RKzylltn98HhOlLlhIigMOrO2WBLeolpCqmPPTNCT1/JfiLyWJ4dvzZI7wtgR2buHy
	 6MCS0v91RtIv2FfwBpBniNtIXN42Io8ZGIqKxcHBVtfJ1vPA+98/+yBl2Ms5PY/vmv
	 9XH8BvM8C4sJOTcU6Nudz2STlus1YTxkVcTUGywBuwsVMHRDqVnt7dZt/i39LU3oLR
	 Q3b7ByUueU+Ww==
Message-ID: <3d17c8c3-6558-4847-b123-4dbe1a1b0763@canonical.com>
Date: Tue, 5 Dec 2023 11:55:08 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Apparmor move_mount mediation breaks mount tool in containers
Content-Language: en-US
To: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Mihalicyn <alexander@mihalicyn.com>,
 "paul@paul-moore.com" <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
 linux-security-module@vger.kernel.org
References: <CA+enf=sWQ+-YP+uj9XfN_ykDsK=CYFFa35aPpeuS9B6qyLkjtg@mail.gmail.com>
 <582eb2e9-ce80-4f96-a4bc-bef1a508e0ab@canonical.com>
 <CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com>
 <fa2124b9-18c1-49b0-b390-398c2dde3fcf@canonical.com>
 <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
 <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/23 22:57, Stéphane Graber wrote:
> On Mon, Dec 4, 2023 at 9:20 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 04.12.23 14:14, John Johansen wrote:
>>> On 12/3/23 17:34, Stéphane Graber wrote:
>>
>> Side note: Stéphane, thx for CCing the regressions list.
>>
>>>> On Sun, Dec 3, 2023 at 8:21 PM John Johansen
>>>> <john.johansen@canonical.com> wrote:
>>>>> On 12/2/23 17:20, Stéphane Graber wrote:
>>>>>>
>>>>>> Upstream commit 157a3537d6bc28ceb9a11fc8cb67f2152d860146 which just
>>>>>> landed in 6.6.3 stable as 96af45154a0be30485ad07f70f852b1456cb13d7 is
>>>>>> blocking new mounts for all LXC, LXD and Incus users (at least) on
>>>>>> distributions using the newer version of util-linux.
>>>>>>
>>>>>> That's because for a simple mount like "mount -t tmpfs tmpfs /tmp",
>>>>>> the new mount command now performs:
>>>>>> ```
>>>>>> fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
>>>>>> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
>>>>>> fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
>>>>>> statx(4, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_MNT_ID,
>>>>>> {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
>>>>>> stx_attributes=STATX_ATTR_MOUNT_ROOT, stx_mode=S_IFDIR|S_ISVTX|0777,
>>>>>> stx_size=40, ...}) = 0
>>>>>> move_mount(4, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH) = 0
>>>>>> ```
>>>>>>
>>>>>> That last call to "move_mount" is incorrectly interpreted by AppArmor
>>>>>> as an attempt to move-mount "/" to "/mnt" rather than as a new mount
>>>>>> being created, this therefore results in:
>>>>>> ```
>>>>>> Dec 03 01:05:03 kernel-test kernel: audit: type=1400
>>>>>> audit(1701565503.599:34): apparmor="DENIED" operation="mount"
>>>>>> class="mount" info="failed perms check" error=-13
>>>>>> profile="incus-a_</var/lib/incus>" name="/tmp/" pid=2190 comm="mount"
>>>>>> srcname="/" flags="rw, move"
>>>>>> ```
>>>>>>
>>>>>> Note that the flags here show "move", the fstype isn't even set and
>>>>>> the source path at srcname incorrectly shows "/".
>>>>>>
>>>>>> This operation therefore trips any container manager which has an
>>>>>> apparmor security policy preventing arbitrary move-mount (as those
>>>>>> could be used to bypass other apparmor path based policies).
>>>>>>
>>>>>>
>>>>>> The way I see it, the current mediation support effectively breaks any
>>>>>> attempt at mediating mounts in a useful way in apparmor as it's now
>>>>>> impossible to mediate new mounts based on their fstype or even
>>>>>> distinguish them from a move-mount operation.
>>>>>>
>>>>> Indeed it is a far from good solution. It is a stop gap.
>>>>>>
>>>>>> I don't know if this warrants pulling the mediation patch out of
>>>>>> stable (and out of linus' tree), obviously doing that would
>>>>>> reintroduce that hole in mount coverage, but at the same time, the
>>>>>> current coverage is broken enough that our only alternative is to
>>>>>> effectively allow all mounts, making the current mediation useless.
>>>>>
>>>>> pulling it effectively means ALL applications by-pass mediation, the
>>>>> alternative is to block all applications from using the move_mount
>>>>> system call as part of mediation. Which might have been acceptable
>>>>> as a stop gap when the syscall first landed but not now.
>>>>
>>>> Pulling it from the stable branch may still make sense, you now have
>>>> folks who are updating to get actual bugfixes and end up with broken
>>>> containers, that doesn't exactly seem like a good outcome...
>>>
>>> I will defer such a decision to the maintainers the stable trees. I
>>> can see arguments either way.
>>
>> FWIW, Greg usually does not revert a backported change if the change
>> causes the same problem to happen with mainline, as then it should be
>> fixed there as well. Which is normally the right thing to do, as Linus
>> wants people to be able to upgrade to new kernels without having them to
>> upgrade anything else (firmware, anything in userland incl. apparmor
>> policies).
>>
>> So normally this whole issue afaics would be "157a3537d6bc28 needs to be
>> fixed in mainline (if nothing else helps with a revert), and that fix
>> then needs to be backported to the various stable trees".
>>
>> It obviously is more complicated because that commit apparently fixes a
>> security vulnerability. But even under such circumstances Linus afaik
>> wants us to do everything possible to avoid breaking peoples workflows.
>> Which is why I wonder if there is a more elegant solution here
>> somewhere. I doubt that the answer is yes, but I'll ask the following
>> anyway: Would a kernel config option that distros could set when they
>> updated their Apparmor policies help here? Or something in sysfs?
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> So there are a few different scenarios here:
> 
> 1) Distribution shipping application specific profiles that were
> developed back when the new VFS mount API wasn't around, those
> profiles allow the specific mount calls made by the application. The
> application has since moved on to using the VFS mount API and thanks
> to the lack of apparmor coverage, things have kept on working fine.
> Now when the distro pulls this bugfix, the application will now fail
> to perform the mount. Apparmor returns EACCESS which doesn't cause a
> fallback to the old mount API but instead a straight up error returned
> to the user. ENOSYS would usually be handled properly.
> 
I am not opposed to conditionally returning ENOSYS. I also have no doubt
that doing so would break fewer applications, it will still break some.
As I said I will look into doing that

> 2) All the container managers out there which use AppArmor as a safety
> net to block mostly misbehaving or misconfigured software. Those
> policies are not meant to be water tight to begin with (and due to the
> nature of containers, they really can't be). But they do catch a lot
> and while not an actual security barrier, they certainly prevent a lot
> of accidents. Unfortunately with the new mediation in place, the only
> real way to operate moving forward is to not mediate mounts at all as
> mediation of the new VFS API leads to just about everything getting
> denied and apparmor doesn't provide a way to separately mediate the
> old and new mount APIs.
> 
atm no, I am working on a conditional for detached mounts. I am not
convinced we should completely separate move_mount() mediation for
attached mounts.

But to use any of that you will need a new apparmor userspace to
support it. LXD is using the mounts as a behavioral/advisory catch, so
allowing an unmediated move_mount() is not the end of the world. Apparmor
still needs to be able to mediate mounts for applications that aren't
containers and do need a tighter barrier.

The reality with the new mount api is that atm we can only mediate
move_mount(), but the new mount api does add a twist with the whole
detached mounts. The only way to support that on older releases is
using a very generic mount rule.

New userspaces can pick up more. Leaving move_mount() unmediated even
for older releases really isn't an appealing option. New kernels
get pulled back and used on old releases all the time.

> 3) A system where apparmor is used to effectively prevent any mounting
> whatsoever, where the policy is now being bypassed by simply using the
> new VFS API. Such a system would also need to not be using Seccomp in
> combination with Apparmor as blocking the new VFS API syscalls would
> avoid the issue.
> 
sure

> 
> I suspect 3) is what John is hinting at in this thread. I could
> certainly see this bug be used to bypass the snapd mount restrictions
> for example, though snapd also generates seccomp policies, so just
> blocking the new VFS API would be a much simpler fix there.
> 
I am concerned about more than the snapd case, yes snapd could and
should use seccomp, but apparmor should be able to stand on its own
for other cases.

> I have no idea how common 1) is, but it looks like we're about to find
> out soon and that has potential for some very "interesting" bug
> reports as mount related errors are usually not the easiest to
> understand and LSMs make them so much worse.
> 
unfortunately that is always the case when fixing a mediation regression.
This one sat way too long that doesn't mean it shouldn't get fixed.

Overall though, I think lxd/incus is probably the major one. Most people
are running targeted policies and have left most of the stuff doing
mounts unconfined.

> As for 2), as it stands, we're going to have to effectively turn off
> any of the mount related safety nets we had in place in LXC, Incus and
> likely most other container runtimes out there to handle this. The
> usual issue with doing that kind of heavy hammer change is that once
> it's done, it will take a long time to undo it. That is, once AppArmor
> is actually capable of mediating the way it's supposed to, a lot of
> the profiles will have been changed to just blanket allow all mounts
> and they're only ever going to be changed once we're confident that
> the vast majority of our users are running a kernel with the fixed
> logic.
> 
I am well aware of it. I fall on the side of leaving this completely
unmediated is slightly worse, but I can understand why someone
would choose to leave this unmediated.

> I guess some of that could be handled better if there was a way to
> detect the current broken mediation of the new mount API and then
> later again, detect that the kernel now has working mediation,
> allowing for those container managers to generate accurate profile
> rather than have to go for the "safest" option (as far as keeping
> users running) and just keep allowing everything.
> 
> John, is there any such detection mechanism currently present that
> could be used by userspace to better handle this situation?
> 
sadly not for the move_mount() patch, it is however a one line patch

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 7465c39ad1bc..6cd52767cfeb 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2373,6 +2373,7 @@ static struct aa_sfs_entry aa_sfs_entry_policy[] = {
  
  static struct aa_sfs_entry aa_sfs_entry_mount[] = {
  	AA_SFS_FILE_STRING("mask", "mount umount pivot_root"),
+	AA_SFS_FILE_STRING(move_mount, "detached"),
  	{ }
  };
  
or similar. That I could send out today.

it would surfaced the via the regular securityfs/apparmor interface as
/sys/kernel/security/apparmor/features/mount/move_mount

I could also get you a simple conditional patch around returning ENOSYS
to start testing, so that we could potentially try sending a final version
of that patch up next week.

> 
> Overall, this still feels very rushed and broken to me. I understand
> that being able to trivially bypass AppArmor mount rules isn't great,
> but shipping code that makes the vast majority of said rules useless
> doesn't really feel like such an improvement. It's effectively turning
> what was a reasonably flexible policy engine around mount calls, into
> a binary switch to either allow everything or block everything.
> 
I get what you are saying. The other side of the coin is oh look apparmor
isn't mediating mount if I just do this ...

> We at the very least need a way to check whether we're dealing with
> this known broken state so that any change that's made to userspace
> can be made condition on this, ensuring that once mediation actually
> works as intended, those policies also go back to the way they're
> supposed to be.
> 
agreed. That really should have been part of the patch to begin with.


