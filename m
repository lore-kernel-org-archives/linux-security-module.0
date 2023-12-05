Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C369293;
	Tue,  5 Dec 2023 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSxvksBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15837C433C8;
	Tue,  5 Dec 2023 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796099;
	bh=4fuUgK13Odh1roGVc/5JGsT0M+PyZLN3gldlT+6e6Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSxvksBPbjM9VRaAsEaziQnKdr4LXV5kiC0SYNLCLul4KpNnuaWoeXw0pR3kO8rQj
	 I6Bfd19Al1HZblyc5dNnrhuDLjMVarfhw6cdDuQKPeTCk0vBdirjoo/636ordHqDug
	 WU3tORjm6m6R3MlKhr2SWEsi9htV1CUkCERs8byk5jwqeK4RwWu5AWy05+qt6j6M8X
	 evlyPYPP1ok3I71hQP9KwNFD2PheTBFDflybBcFEXJHbP55QlG5Tdw/7Pr6BKbXJsl
	 3HEicNjzmvY8dHzHpKwz1wiZYkcVZsduzDTNFr4uJWI6u9+cpJsPDD1RcCtstKU0rK
	 TdhL3+uzLfUog==
Date: Tue, 5 Dec 2023 18:08:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Mihalicyn <alexander@mihalicyn.com>,
	"paul@paul-moore.com" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Apparmor move_mount mediation breaks mount tool in containers
Message-ID: <20231205-goldwaage-faszination-97b57cbc24b9@brauner>
References: <CA+enf=sWQ+-YP+uj9XfN_ykDsK=CYFFa35aPpeuS9B6qyLkjtg@mail.gmail.com>
 <582eb2e9-ce80-4f96-a4bc-bef1a508e0ab@canonical.com>
 <CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com>
 <fa2124b9-18c1-49b0-b390-398c2dde3fcf@canonical.com>
 <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
 <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com>
 <d9a402cc-9f47-40c7-9c1b-76c318fd91c4@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9a402cc-9f47-40c7-9c1b-76c318fd91c4@leemhuis.info>

On Tue, Dec 05, 2023 at 09:45:35AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing Linus]
> 
> Hi, top-posting for once, to make this easily accessible to everyone.
> 
> Stéphane, many thx for your insights.
> 
> I'm CCing Linus on this, as I guess he wants to be aware of this.
> 
> Normally I try to sum up things somewhat when doing so, but this here
> likely won't end well. So all I'm saying is: commit 157a3537d6bc28
> ("apparmor: Fix regression in mount mediation") [v6.7-rc1] that was also
> included in v6.6.3 broke containers in some setups. John described that
> commit with the words "it is a far from good solution. It is a stop
> gap." and later mentioned that "a CVE is coming for this and that having
> this unmediated in the tree isn't good either."
> 
> For more details please check out the thread that on lore started with
> this message:
> 
> https://lore.kernel.org/all/CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> On 05.12.23 07:57, Stéphane Graber wrote:
> > On Mon, Dec 4, 2023 at 9:20 AM Linux regression tracking (Thorsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> On 04.12.23 14:14, John Johansen wrote:
> >>> On 12/3/23 17:34, Stéphane Graber wrote:
> >>
> >> Side note: Stéphane, thx for CCing the regressions list.
> >>
> >>>> On Sun, Dec 3, 2023 at 8:21 PM John Johansen
> >>>> <john.johansen@canonical.com> wrote:
> >>>>> On 12/2/23 17:20, Stéphane Graber wrote:
> >>>>>>
> >>>>>> Upstream commit 157a3537d6bc28ceb9a11fc8cb67f2152d860146 which just
> >>>>>> landed in 6.6.3 stable as 96af45154a0be30485ad07f70f852b1456cb13d7 is
> >>>>>> blocking new mounts for all LXC, LXD and Incus users (at least) on
> >>>>>> distributions using the newer version of util-linux.
> >>>>>>
> >>>>>> That's because for a simple mount like "mount -t tmpfs tmpfs /tmp",
> >>>>>> the new mount command now performs:
> >>>>>> ```
> >>>>>> fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
> >>>>>> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
> >>>>>> fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
> >>>>>> statx(4, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_MNT_ID,
> >>>>>> {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
> >>>>>> stx_attributes=STATX_ATTR_MOUNT_ROOT, stx_mode=S_IFDIR|S_ISVTX|0777,
> >>>>>> stx_size=40, ...}) = 0
> >>>>>> move_mount(4, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH) = 0
> >>>>>> ```
> >>>>>>
> >>>>>> That last call to "move_mount" is incorrectly interpreted by AppArmor
> >>>>>> as an attempt to move-mount "/" to "/mnt" rather than as a new mount
> >>>>>> being created, this therefore results in:
> >>>>>> ```
> >>>>>> Dec 03 01:05:03 kernel-test kernel: audit: type=1400
> >>>>>> audit(1701565503.599:34): apparmor="DENIED" operation="mount"
> >>>>>> class="mount" info="failed perms check" error=-13
> >>>>>> profile="incus-a_</var/lib/incus>" name="/tmp/" pid=2190 comm="mount"
> >>>>>> srcname="/" flags="rw, move"
> >>>>>> ```

move_mount() doesn't create a new mount it just moves an already
existing mount around in the tree. Either that mount is moved
(fsmount(), open_tree(OPEN_TREE_CLONE)) from it's source location or it
was a detached mount to begin with.

The new mount api splits mounting across multiple system calls. And the
state it keeps for itself is gone once you create a mount via fsmount().
Because then the fs_context will be destroyed and you're only dealing
with a superblock and mount(s) for it.

You shouldn't care about move_mount() moving a detached mount because
really it is not a move from some other filesystem location. The
creation of that mount will have already happened in
open_tree(OPEN_TREE_CLONE) or in fsmount(). So that ship has sailed and
move_mount() is the wrong place to do this.

If the only thing that would be broken here is that you want to block
moving mounts from a given source location then you need to pass down
that this is an actual move to the LSM hook. Because I'm really not keen
on giving LSMs access to is_anon_ns() or similar helpers. They're just
too easy to misuse.

> > Overall, this still feels very rushed and broken to me. I understand
> > that being able to trivially bypass AppArmor mount rules isn't great,
> > but shipping code that makes the vast majority of said rules useless
> > doesn't really feel like such an improvement. It's effectively turning
> > what was a reasonably flexible policy engine around mount calls, into
> > a binary switch to either allow everything or block everything.

For a 1:1 mapping of AppArmor LSM rules from the old to the new mount
api I expect that one will have to effectively redo everything
internally and keep state across multiple system calls. IMO, this is
really not the way to go. Instead it's probably wise to have a new mount
mediation policy for the new mount api with different semantics. Because
I have my doubts that a 1:1 mapping will even work and won't just cause
you CVEs.
