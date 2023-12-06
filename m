Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AJ6Nh4yV"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C498F
	for <linux-security-module@vger.kernel.org>; Wed,  6 Dec 2023 11:21:28 -0800 (PST)
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF14E42FEA;
	Wed,  6 Dec 2023 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701890485;
	bh=K/tdXr6jVzr1/VM41uImJAnVMWVvg+HQMRTEountDS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=AJ6Nh4yV5e1MTUHlpRUO2goNNFTxxCn1k+Z75K2kd8VpqJnnOq7T3NubxLIB+1Nxo
	 zFdbQxnR6DjzuXe4CezRQoySWzr3B+NrH/wdThcBctnzioO13+p/uAp/YLfbsBRekl
	 yUNnwb0QJT5EiuHD8Hbe/naNH9bEA7Q3zxMFp0BhLCSapNw7Z0UQSYp0HSfVZ4xDWK
	 vw+qMAxhoSax7+o3oqxIlVYEyPGtFMGFcVwaZd0jBGJwwD9vZes09ACKyQ0U0i2I1F
	 fDH7ygm7eQ9nYjmL3oyw1RtIl4c4o5XylO1l7ln+hXsxwIR5+SyO+AUPzKhQuXXdIq
	 ZPP+Kskxb6OyA==
Message-ID: <dea3be0e-3a52-4561-b4ea-a6b25db48601@canonical.com>
Date: Wed, 6 Dec 2023 11:21:12 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Apparmor move_mount mediation breaks mount tool in containers
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Sasha Levin <sashal@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Mihalicyn <alexander@mihalicyn.com>,
 "paul@paul-moore.com" <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CA+enf=sWQ+-YP+uj9XfN_ykDsK=CYFFa35aPpeuS9B6qyLkjtg@mail.gmail.com>
 <582eb2e9-ce80-4f96-a4bc-bef1a508e0ab@canonical.com>
 <CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com>
 <fa2124b9-18c1-49b0-b390-398c2dde3fcf@canonical.com>
 <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
 <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com>
 <d9a402cc-9f47-40c7-9c1b-76c318fd91c4@leemhuis.info>
 <20231205-goldwaage-faszination-97b57cbc24b9@brauner>
 <862e8daa-e586-4627-8698-0416a4eba155@canonical.com>
 <20231206-umgang-kaution-00dac707e334@brauner>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20231206-umgang-kaution-00dac707e334@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/6/23 06:12, Christian Brauner wrote:
> On Tue, Dec 05, 2023 at 10:34:33AM -0800, John Johansen wrote:
>> On 12/5/23 09:08, Christian Brauner wrote:
>>> On Tue, Dec 05, 2023 at 09:45:35AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> [CCing Linus]
>>>>
>>>> Hi, top-posting for once, to make this easily accessible to everyone.
>>>>
>>>> Stéphane, many thx for your insights.
>>>>
>>>> I'm CCing Linus on this, as I guess he wants to be aware of this.
>>>>
>>>> Normally I try to sum up things somewhat when doing so, but this here
>>>> likely won't end well. So all I'm saying is: commit 157a3537d6bc28
>>>> ("apparmor: Fix regression in mount mediation") [v6.7-rc1] that was also
>>>> included in v6.6.3 broke containers in some setups. John described that
>>>> commit with the words "it is a far from good solution. It is a stop
>>>> gap." and later mentioned that "a CVE is coming for this and that having
>>>> this unmediated in the tree isn't good either."
>>>>
>>>> For more details please check out the thread that on lore started with
>>>> this message:
>>>>
>>>> https://lore.kernel.org/all/CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> If I did something stupid, please tell me, as explained on that page.
>>>>
>>>> On 05.12.23 07:57, Stéphane Graber wrote:
>>>>> On Mon, Dec 4, 2023 at 9:20 AM Linux regression tracking (Thorsten
>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>
>>>>>> On 04.12.23 14:14, John Johansen wrote:
>>>>>>> On 12/3/23 17:34, Stéphane Graber wrote:
>>>>>>
>>>>>> Side note: Stéphane, thx for CCing the regressions list.
>>>>>>
>>>>>>>> On Sun, Dec 3, 2023 at 8:21 PM John Johansen
>>>>>>>> <john.johansen@canonical.com> wrote:
>>>>>>>>> On 12/2/23 17:20, Stéphane Graber wrote:
>>>>>>>>>>
>>>>>>>>>> Upstream commit 157a3537d6bc28ceb9a11fc8cb67f2152d860146 which just
>>>>>>>>>> landed in 6.6.3 stable as 96af45154a0be30485ad07f70f852b1456cb13d7 is
>>>>>>>>>> blocking new mounts for all LXC, LXD and Incus users (at least) on
>>>>>>>>>> distributions using the newer version of util-linux.
>>>>>>>>>>
>>>>>>>>>> That's because for a simple mount like "mount -t tmpfs tmpfs /tmp",
>>>>>>>>>> the new mount command now performs:
>>>>>>>>>> ```
>>>>>>>>>> fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
>>>>>>>>>> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
>>>>>>>>>> fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
>>>>>>>>>> statx(4, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_MNT_ID,
>>>>>>>>>> {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
>>>>>>>>>> stx_attributes=STATX_ATTR_MOUNT_ROOT, stx_mode=S_IFDIR|S_ISVTX|0777,
>>>>>>>>>> stx_size=40, ...}) = 0
>>>>>>>>>> move_mount(4, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH) = 0
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>> That last call to "move_mount" is incorrectly interpreted by AppArmor
>>>>>>>>>> as an attempt to move-mount "/" to "/mnt" rather than as a new mount
>>>>>>>>>> being created, this therefore results in:
>>>>>>>>>> ```
>>>>>>>>>> Dec 03 01:05:03 kernel-test kernel: audit: type=1400
>>>>>>>>>> audit(1701565503.599:34): apparmor="DENIED" operation="mount"
>>>>>>>>>> class="mount" info="failed perms check" error=-13
>>>>>>>>>> profile="incus-a_</var/lib/incus>" name="/tmp/" pid=2190 comm="mount"
>>>>>>>>>> srcname="/" flags="rw, move"
>>>>>>>>>> ```
>>>
>>> move_mount() doesn't create a new mount it just moves an already
>>> existing mount around in the tree. Either that mount is moved
>>> (fsmount(), open_tree(OPEN_TREE_CLONE)) from it's source location or it
>>> was a detached mount to begin with.
>>>
>> yes, all to aware of this
>>
>>> The new mount api splits mounting across multiple system calls. And the
>>> state it keeps for itself is gone once you create a mount via fsmount().
>>
>> yep
>>
>>> Because then the fs_context will be destroyed and you're only dealing
>>> with a superblock and mount(s) for it.
>>>
>> yep
>>
>>> You shouldn't care about move_mount() moving a detached mount because
>>> really it is not a move from some other filesystem location. The
>>> creation of that mount will have already happened in
>>> open_tree(OPEN_TREE_CLONE) or in fsmount(). So that ship has sailed and
>>> move_mount() is the wrong place to do this.
>>>
>> yes and no. What we are specifically dong is mediating existing attached
>> mounts as always and blocking move_mount from attaching the detached
>> mount via move_mount. Which is very much something move_mount mediation
>> should be able to do.
> 
> Yes, but my point is that it's often at the wrong point in time. You
> can mediate this earlier as well - see my open_tree() comment below.
> 

yes, there needs to be mediation happening earlier as well. The goal
here wasn't complete new mount api mediation, which is something that
we have been meaning to address but haven't been able to yet.

This was specifically about addressing move_mount() which can also
be used to move existing mounts in the system. While fixing that the
question is do we care about detached mounts, yes, and should we
address them to the point that we can within the current mediation,
that is to gate them on very course is mount mediation allowed, and from
a security perspective that is a yes too.

Under the new mount api, even if we are mediating at the other points
brought up below, we still want to be mediating the move_mount
because apparmor very much cares where these mounts end up in
the mount tree.


>>
>> It works as a stop gap for the new mount api bypassing the LSM at a very
>> course level. This is why it requires a very general mount rule for
>> apparmor to allow move_mount of the detached mount. A conditional that
>> improves control around this is coming, but we can't make move_mount()
>> mediation provide the full set of apparmor old mount mediation.
>>
>> Providing something close to what we were doing before is going to
>> require new hooks, and likely specialized states tailored to the
>> new mount api. Until that does happen it does mean a reduction in
>> what apparmor policy can mediate. Today instead of being able to
>> specify details about the mount you need a generic mount rule that
>> just allows the application to do pretty much anything with mounts,
>> soon you will be able to have an addition conditional that allows
>> better control of move mount, and better logging of what is going on.
> 
> If you want to start doing full mediation for the new mount api you're
> likely missing quite a few pieces.
> 
> I expect you need a hook in at least fsmount() as this always creates a
> detached mount for a new filesystem context (You touched on that in an
> earlier mail.).
> 
yes

> But you also need a new hook in open_tree() but _only_ in the
> OPEN_TREE_CLONE path because that creates detached mounts as well.
> 
yes

> And you will also very likely want a new hook in mount_setattr() because
> that allows you to change mount properties as well and the creation of
> idmapped mounts and so on.

agreed.

