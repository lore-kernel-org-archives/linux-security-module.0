Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9C3FF5;
	Wed,  6 Dec 2023 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC08/D75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49927C433C7;
	Wed,  6 Dec 2023 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701871979;
	bh=vRZJltfG/9jxYlO20NP4li4eCOel1OH5sVB3weAUVPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fC08/D75eXfLMJq6hPN9P7mHN7Se8PkCAi0mEbTzb4YZXk9aeYIqZADelnxK50qO7
	 v9ixQ7LyO5rn8OCXOS/3L5ASrMoJfCGgRywLiVXRgRTPMHHUI60RWMC28UqlUJh0aE
	 Rsg9mXaALLmV2keFyO6eo6UTc4XYWNmHgUksOEHohRwIqzKqbEWLPA+MrLGA0SrfDE
	 qV6PaGkp2EgjNKoINYkg+QYAK3p0JdzmlLquQPxSFR2zC1ZPw6hm2qGubQRGupGB08
	 /XOTGcX2kRuNhGz0CLXIDrqnSRwI4dVmOWuRjRqgZNlkGxJKPONvF6a1/u944p14xY
	 ExMW6k90ctJAQ==
Date: Wed, 6 Dec 2023 15:12:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
	Sasha Levin <sashal@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Mihalicyn <alexander@mihalicyn.com>,
	"paul@paul-moore.com" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Apparmor move_mount mediation breaks mount tool in containers
Message-ID: <20231206-umgang-kaution-00dac707e334@brauner>
References: <CA+enf=sWQ+-YP+uj9XfN_ykDsK=CYFFa35aPpeuS9B6qyLkjtg@mail.gmail.com>
 <582eb2e9-ce80-4f96-a4bc-bef1a508e0ab@canonical.com>
 <CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com>
 <fa2124b9-18c1-49b0-b390-398c2dde3fcf@canonical.com>
 <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
 <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com>
 <d9a402cc-9f47-40c7-9c1b-76c318fd91c4@leemhuis.info>
 <20231205-goldwaage-faszination-97b57cbc24b9@brauner>
 <862e8daa-e586-4627-8698-0416a4eba155@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <862e8daa-e586-4627-8698-0416a4eba155@canonical.com>

On Tue, Dec 05, 2023 at 10:34:33AM -0800, John Johansen wrote:
> On 12/5/23 09:08, Christian Brauner wrote:
> > On Tue, Dec 05, 2023 at 09:45:35AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > [CCing Linus]
> > > 
> > > Hi, top-posting for once, to make this easily accessible to everyone.
> > > 
> > > Stéphane, many thx for your insights.
> > > 
> > > I'm CCing Linus on this, as I guess he wants to be aware of this.
> > > 
> > > Normally I try to sum up things somewhat when doing so, but this here
> > > likely won't end well. So all I'm saying is: commit 157a3537d6bc28
> > > ("apparmor: Fix regression in mount mediation") [v6.7-rc1] that was also
> > > included in v6.6.3 broke containers in some setups. John described that
> > > commit with the words "it is a far from good solution. It is a stop
> > > gap." and later mentioned that "a CVE is coming for this and that having
> > > this unmediated in the tree isn't good either."
> > > 
> > > For more details please check out the thread that on lore started with
> > > this message:
> > > 
> > > https://lore.kernel.org/all/CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/
> > > 
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > > --
> > > Everything you wanna know about Linux kernel regression tracking:
> > > https://linux-regtracking.leemhuis.info/about/#tldr
> > > If I did something stupid, please tell me, as explained on that page.
> > > 
> > > On 05.12.23 07:57, Stéphane Graber wrote:
> > > > On Mon, Dec 4, 2023 at 9:20 AM Linux regression tracking (Thorsten
> > > > Leemhuis) <regressions@leemhuis.info> wrote:
> > > > > 
> > > > > On 04.12.23 14:14, John Johansen wrote:
> > > > > > On 12/3/23 17:34, Stéphane Graber wrote:
> > > > > 
> > > > > Side note: Stéphane, thx for CCing the regressions list.
> > > > > 
> > > > > > > On Sun, Dec 3, 2023 at 8:21 PM John Johansen
> > > > > > > <john.johansen@canonical.com> wrote:
> > > > > > > > On 12/2/23 17:20, Stéphane Graber wrote:
> > > > > > > > > 
> > > > > > > > > Upstream commit 157a3537d6bc28ceb9a11fc8cb67f2152d860146 which just
> > > > > > > > > landed in 6.6.3 stable as 96af45154a0be30485ad07f70f852b1456cb13d7 is
> > > > > > > > > blocking new mounts for all LXC, LXD and Incus users (at least) on
> > > > > > > > > distributions using the newer version of util-linux.
> > > > > > > > > 
> > > > > > > > > That's because for a simple mount like "mount -t tmpfs tmpfs /tmp",
> > > > > > > > > the new mount command now performs:
> > > > > > > > > ```
> > > > > > > > > fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
> > > > > > > > > fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
> > > > > > > > > fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
> > > > > > > > > statx(4, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_MNT_ID,
> > > > > > > > > {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
> > > > > > > > > stx_attributes=STATX_ATTR_MOUNT_ROOT, stx_mode=S_IFDIR|S_ISVTX|0777,
> > > > > > > > > stx_size=40, ...}) = 0
> > > > > > > > > move_mount(4, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH) = 0
> > > > > > > > > ```
> > > > > > > > > 
> > > > > > > > > That last call to "move_mount" is incorrectly interpreted by AppArmor
> > > > > > > > > as an attempt to move-mount "/" to "/mnt" rather than as a new mount
> > > > > > > > > being created, this therefore results in:
> > > > > > > > > ```
> > > > > > > > > Dec 03 01:05:03 kernel-test kernel: audit: type=1400
> > > > > > > > > audit(1701565503.599:34): apparmor="DENIED" operation="mount"
> > > > > > > > > class="mount" info="failed perms check" error=-13
> > > > > > > > > profile="incus-a_</var/lib/incus>" name="/tmp/" pid=2190 comm="mount"
> > > > > > > > > srcname="/" flags="rw, move"
> > > > > > > > > ```
> > 
> > move_mount() doesn't create a new mount it just moves an already
> > existing mount around in the tree. Either that mount is moved
> > (fsmount(), open_tree(OPEN_TREE_CLONE)) from it's source location or it
> > was a detached mount to begin with.
> > 
> yes, all to aware of this
> 
> > The new mount api splits mounting across multiple system calls. And the
> > state it keeps for itself is gone once you create a mount via fsmount().
> 
> yep
> 
> > Because then the fs_context will be destroyed and you're only dealing
> > with a superblock and mount(s) for it.
> > 
> yep
> 
> > You shouldn't care about move_mount() moving a detached mount because
> > really it is not a move from some other filesystem location. The
> > creation of that mount will have already happened in
> > open_tree(OPEN_TREE_CLONE) or in fsmount(). So that ship has sailed and
> > move_mount() is the wrong place to do this.
> > 
> yes and no. What we are specifically dong is mediating existing attached
> mounts as always and blocking move_mount from attaching the detached
> mount via move_mount. Which is very much something move_mount mediation
> should be able to do.

Yes, but my point is that it's often at the wrong point in time. You
can mediate this earlier as well - see my open_tree() comment below.

> 
> It works as a stop gap for the new mount api bypassing the LSM at a very
> course level. This is why it requires a very general mount rule for
> apparmor to allow move_mount of the detached mount. A conditional that
> improves control around this is coming, but we can't make move_mount()
> mediation provide the full set of apparmor old mount mediation.
> 
> Providing something close to what we were doing before is going to
> require new hooks, and likely specialized states tailored to the
> new mount api. Until that does happen it does mean a reduction in
> what apparmor policy can mediate. Today instead of being able to
> specify details about the mount you need a generic mount rule that
> just allows the application to do pretty much anything with mounts,
> soon you will be able to have an addition conditional that allows
> better control of move mount, and better logging of what is going on.

If you want to start doing full mediation for the new mount api you're
likely missing quite a few pieces. 

I expect you need a hook in at least fsmount() as this always creates a
detached mount for a new filesystem context (You touched on that in an
earlier mail.).

But you also need a new hook in open_tree() but _only_ in the
OPEN_TREE_CLONE path because that creates detached mounts as well.

And you will also very likely want a new hook in mount_setattr() because
that allows you to change mount properties as well and the creation of
idmapped mounts and so on.
