Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stgraber.org header.i=@stgraber.org header.b="dAAqTNuj"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE47FA
	for <linux-security-module@vger.kernel.org>; Mon,  4 Dec 2023 22:57:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so6737477a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 04 Dec 2023 22:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stgraber.org; s=google; t=1701759472; x=1702364272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukODk/TwQTwR+YiB9UzoHoJTY7E4UFaFmw12dC/rlPY=;
        b=dAAqTNuj5XH8XWgtfJs1y/P2IAgi5fMa5rXA5R/iMDxl8toSm0b3ZtV1LvFc5k0DL7
         8EiLidBq7LjrGSuRvMaHk1h4DdcRUW9ZQ7zGgIvPppNiN6wlwBm7NTFFB0IOnRDs3KTH
         LD3xt1AwdVJVJb82E0UcEmuKEZPsqg4dey2Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701759472; x=1702364272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukODk/TwQTwR+YiB9UzoHoJTY7E4UFaFmw12dC/rlPY=;
        b=B3ivLe8SI8hoXW9Jq2wGk6Ccqjea9+wG1Ji3iAIGYGliIVC8wnGNsXbUlCuqO6IhpM
         7liZC1HUHCvWWUH8AwD/5ZRWhxKC5tdzV6anlDRJvJ0XdYhUBxD+0hv6Z+5Y1LdKZeQL
         3F0wMObcQXZn4uiT7mytE2cgP+hJVaOIj8JkrgZpnbgxj9ZzjydoQWsNsXlIhOzc65Td
         mS/ktymZiHauqY7QVMsumKcXYzrTerzU4yu5Jdk5AKVOXZGekfPCYDcbafYdRrxC1wDZ
         pfaaMWsAQQu/jyNhhuBu30E50sc3XSECZ4g2ACouo8OQyHiq2BJRD3kCWAanRhVfyxY7
         huNA==
X-Gm-Message-State: AOJu0Yyh9iuVM/2N6XT9vUt9pj3TKuQbN8DAwgylpl5fr1QjoGQFcGsO
	G0QgT7nyISeGDZvETZnMEawcX19XT2U8izcfPVtGow==
X-Google-Smtp-Source: AGHT+IEtFoMwukI6sWmQkZghTCZS6Z5EUQsstYH8ujX7E8QJNQmLYWKJyPOeulh57+t6ytbf46RnuCCV2nBwqzgmGds=
X-Received: by 2002:a50:cc95:0:b0:54c:7994:ac02 with SMTP id
 q21-20020a50cc95000000b0054c7994ac02mr2509217edi.33.1701759471005; Mon, 04
 Dec 2023 22:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+enf=sWQ+-YP+uj9XfN_ykDsK=CYFFa35aPpeuS9B6qyLkjtg@mail.gmail.com>
 <582eb2e9-ce80-4f96-a4bc-bef1a508e0ab@canonical.com> <CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com>
 <fa2124b9-18c1-49b0-b390-398c2dde3fcf@canonical.com> <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
In-Reply-To: <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
From: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Date: Tue, 5 Dec 2023 01:57:39 -0500
Message-ID: <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com>
Subject: Re: Apparmor move_mount mediation breaks mount tool in containers
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: John Johansen <john.johansen@canonical.com>, Christian Brauner <brauner@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Mihalicyn <alexander@mihalicyn.com>, "paul@paul-moore.com" <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:20=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 04.12.23 14:14, John Johansen wrote:
> > On 12/3/23 17:34, St=C3=A9phane Graber wrote:
>
> Side note: St=C3=A9phane, thx for CCing the regressions list.
>
> >> On Sun, Dec 3, 2023 at 8:21=E2=80=AFPM John Johansen
> >> <john.johansen@canonical.com> wrote:
> >>> On 12/2/23 17:20, St=C3=A9phane Graber wrote:
> >>>>
> >>>> Upstream commit 157a3537d6bc28ceb9a11fc8cb67f2152d860146 which just
> >>>> landed in 6.6.3 stable as 96af45154a0be30485ad07f70f852b1456cb13d7 i=
s
> >>>> blocking new mounts for all LXC, LXD and Incus users (at least) on
> >>>> distributions using the newer version of util-linux.
> >>>>
> >>>> That's because for a simple mount like "mount -t tmpfs tmpfs /tmp",
> >>>> the new mount command now performs:
> >>>> ```
> >>>> fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) =3D 0
> >>>> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) =3D 0
> >>>> fsmount(3, FSMOUNT_CLOEXEC, 0)          =3D 4
> >>>> statx(4, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_MNT_ID,
> >>>> {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID,
> >>>> stx_attributes=3DSTATX_ATTR_MOUNT_ROOT, stx_mode=3DS_IFDIR|S_ISVTX|0=
777,
> >>>> stx_size=3D40, ...}) =3D 0
> >>>> move_mount(4, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH) =3D 0
> >>>> ```
> >>>>
> >>>> That last call to "move_mount" is incorrectly interpreted by AppArmo=
r
> >>>> as an attempt to move-mount "/" to "/mnt" rather than as a new mount
> >>>> being created, this therefore results in:
> >>>> ```
> >>>> Dec 03 01:05:03 kernel-test kernel: audit: type=3D1400
> >>>> audit(1701565503.599:34): apparmor=3D"DENIED" operation=3D"mount"
> >>>> class=3D"mount" info=3D"failed perms check" error=3D-13
> >>>> profile=3D"incus-a_</var/lib/incus>" name=3D"/tmp/" pid=3D2190 comm=
=3D"mount"
> >>>> srcname=3D"/" flags=3D"rw, move"
> >>>> ```
> >>>>
> >>>> Note that the flags here show "move", the fstype isn't even set and
> >>>> the source path at srcname incorrectly shows "/".
> >>>>
> >>>> This operation therefore trips any container manager which has an
> >>>> apparmor security policy preventing arbitrary move-mount (as those
> >>>> could be used to bypass other apparmor path based policies).
> >>>>
> >>>>
> >>>> The way I see it, the current mediation support effectively breaks a=
ny
> >>>> attempt at mediating mounts in a useful way in apparmor as it's now
> >>>> impossible to mediate new mounts based on their fstype or even
> >>>> distinguish them from a move-mount operation.
> >>>>
> >>> Indeed it is a far from good solution. It is a stop gap.
> >>>>
> >>>> I don't know if this warrants pulling the mediation patch out of
> >>>> stable (and out of linus' tree), obviously doing that would
> >>>> reintroduce that hole in mount coverage, but at the same time, the
> >>>> current coverage is broken enough that our only alternative is to
> >>>> effectively allow all mounts, making the current mediation useless.
> >>>
> >>> pulling it effectively means ALL applications by-pass mediation, the
> >>> alternative is to block all applications from using the move_mount
> >>> system call as part of mediation. Which might have been acceptable
> >>> as a stop gap when the syscall first landed but not now.
> >>
> >> Pulling it from the stable branch may still make sense, you now have
> >> folks who are updating to get actual bugfixes and end up with broken
> >> containers, that doesn't exactly seem like a good outcome...
> >
> > I will defer such a decision to the maintainers the stable trees. I
> > can see arguments either way.
>
> FWIW, Greg usually does not revert a backported change if the change
> causes the same problem to happen with mainline, as then it should be
> fixed there as well. Which is normally the right thing to do, as Linus
> wants people to be able to upgrade to new kernels without having them to
> upgrade anything else (firmware, anything in userland incl. apparmor
> policies).
>
> So normally this whole issue afaics would be "157a3537d6bc28 needs to be
> fixed in mainline (if nothing else helps with a revert), and that fix
> then needs to be backported to the various stable trees".
>
> It obviously is more complicated because that commit apparently fixes a
> security vulnerability. But even under such circumstances Linus afaik
> wants us to do everything possible to avoid breaking peoples workflows.
> Which is why I wonder if there is a more elegant solution here
> somewhere. I doubt that the answer is yes, but I'll ask the following
> anyway: Would a kernel config option that distros could set when they
> updated their Apparmor policies help here? Or something in sysfs?
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

So there are a few different scenarios here:

1) Distribution shipping application specific profiles that were
developed back when the new VFS mount API wasn't around, those
profiles allow the specific mount calls made by the application. The
application has since moved on to using the VFS mount API and thanks
to the lack of apparmor coverage, things have kept on working fine.
Now when the distro pulls this bugfix, the application will now fail
to perform the mount. Apparmor returns EACCESS which doesn't cause a
fallback to the old mount API but instead a straight up error returned
to the user. ENOSYS would usually be handled properly.

2) All the container managers out there which use AppArmor as a safety
net to block mostly misbehaving or misconfigured software. Those
policies are not meant to be water tight to begin with (and due to the
nature of containers, they really can't be). But they do catch a lot
and while not an actual security barrier, they certainly prevent a lot
of accidents. Unfortunately with the new mediation in place, the only
real way to operate moving forward is to not mediate mounts at all as
mediation of the new VFS API leads to just about everything getting
denied and apparmor doesn't provide a way to separately mediate the
old and new mount APIs.

3) A system where apparmor is used to effectively prevent any mounting
whatsoever, where the policy is now being bypassed by simply using the
new VFS API. Such a system would also need to not be using Seccomp in
combination with Apparmor as blocking the new VFS API syscalls would
avoid the issue.


I suspect 3) is what John is hinting at in this thread. I could
certainly see this bug be used to bypass the snapd mount restrictions
for example, though snapd also generates seccomp policies, so just
blocking the new VFS API would be a much simpler fix there.

I have no idea how common 1) is, but it looks like we're about to find
out soon and that has potential for some very "interesting" bug
reports as mount related errors are usually not the easiest to
understand and LSMs make them so much worse.

As for 2), as it stands, we're going to have to effectively turn off
any of the mount related safety nets we had in place in LXC, Incus and
likely most other container runtimes out there to handle this. The
usual issue with doing that kind of heavy hammer change is that once
it's done, it will take a long time to undo it. That is, once AppArmor
is actually capable of mediating the way it's supposed to, a lot of
the profiles will have been changed to just blanket allow all mounts
and they're only ever going to be changed once we're confident that
the vast majority of our users are running a kernel with the fixed
logic.

I guess some of that could be handled better if there was a way to
detect the current broken mediation of the new mount API and then
later again, detect that the kernel now has working mediation,
allowing for those container managers to generate accurate profile
rather than have to go for the "safest" option (as far as keeping
users running) and just keep allowing everything.

John, is there any such detection mechanism currently present that
could be used by userspace to better handle this situation?


Overall, this still feels very rushed and broken to me. I understand
that being able to trivially bypass AppArmor mount rules isn't great,
but shipping code that makes the vast majority of said rules useless
doesn't really feel like such an improvement. It's effectively turning
what was a reasonably flexible policy engine around mount calls, into
a binary switch to either allow everything or block everything.

We at the very least need a way to check whether we're dealing with
this known broken state so that any change that's made to userspace
can be made condition on this, ensuring that once mediation actually
works as intended, those policies also go back to the way they're
supposed to be.

St=C3=A9phane

> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> > But I will note that even if we had been able perfectly match the
> > new interface mediation to the old breakage is still possible because
> > containers could have been using new interface to do things not
> > covered by the old interface rules.
> >
> > Not that it matters to the upstream kernel maintainers but a CVE
> > is coming for this and that having this unmediated in the tree isn't
> > good either.
> >
> >>> The situation can be broken down like this
> >>> unconfined applications have no restrictions, this doesn't affect
> >>> hem.
> >>>
> >>> confined applications using the old mount interface continue to
> >>> work as expected.
> >>>
> >>> confined applications using the new mount interface now are blocked
> >>> unless there is, admittedly, a very broad mount rule granted. This
> >>> is however better than the old situation in which confined
> >>> applications where not mediated at all.
> >>
> >> It depends from your point of view. If you are using apparmor around a
> >> single application and have tailored rules for exactly what it is
> >> doing, then yes, I agree.
> >> But for all cases where apparmor is used as a safety net to block
> >> potentially dangerous/problematic actions, this is causing the kind of
> >> breakage which will cause people to just plain turn off apparmor.
> >>
> >
> > Only in the sense that closing a security regression causes breakage.
> >
> > Lets cover the cases.
> > Policy is not updated, and application uses the old mount interface:
> > this continues to work.
> >
> > *Policy is not updated, and application uses the new mount interface:
> > the access is likely blocked (the security hole has been closed)
> > unless the policy already allowed a generic
> >   allow mount,
> >
> > +Policy is updated with generic
> >   allow mount,
> > and application uses the old mount interface:
> > this continues to work, security restrictions are reduced on the
> > old interface, but policy reflects what can actually be enforced
> > around mount, because if the application is compromised and uses
> > the new mount interface this is what can be mediated.
> >
> > Policy is updated with generic
> >   allow mount,
> > and application uses the new mount interface:
> > The application continues to work.
> >
> > * The breakage case is where the application was using the new
> > interface and not being mediated. While being able to mediate
> > the new interface to the same level of the old would help, it
> > does not guarantee this case won't break, as the application
> > could be using to do things that are not restricted by current
> > policy.
> >
> > + The regressed mediation case, is only sort of reduced mediation.
> > The policy can maintain all existing mount rules so that info
> > is not lost going forward.
> > The mediation on the old mount interface is reduced by the new
> > mount rule, but at the same time it now possible to turn of
> > the new mount interface, if mount is not being used by the
> > application.
> >
> >>> The regression is in the policy, where an application like LXD/Incus
> >>> are specify mount rules and loading policy based on it. Those
> >>> restrictions continue to work on the old mount interface, they
> >>> however do not work as one would expect when the new mount interface
> >>> is used. To allow applications to use the new mount interface
> >>> a broad mount rule is needed, which basically makes the other
> >>> mount restrictions useless.
> >>>
> >>> This situation is however still better than without the patch
> >>> because, applications trying to use the new mount interface
> >>> were not restricted at all. The only regression is in mediation
> >>> of applications that are using the old mount interface. But
> >>> again those application, without the patch, can just use the
> >>> new interface and by-pass the restrictions from those rules. In
> >>> this case the broad rule is not good, but better than the by-pass.
> >>>
> >>> I am working on a patch that will improve the situation, over the
> >>> current patch using the existing move_mount hook. I wanted to
> >>> be able to get more testing in place, before we did more, and
> >>> just didn't have the time.
> >>
> >> So just to understand, this change went upstream while it was known
> >> that effectively no sane mount policy would work with it?
> >>
> >
> > having a toggle to turn off mount is sane. It actually is a little
> > better than that in that you can do more with some cases. It still
> > allows full mediation under the old interface, it just can't match
> > how fine the mediation is with the old interface.
> >
> >> That seems very odd, at that point, why not instead upstream a patch
> >> that disables the new mount API when apparmor is in use with mount
> >> rules?
> >
> > It breaks applications, some will fallback, some don't. Here you
> > get a policy controllable toggle. Admittedly it returns -EACCES
> > instead of a different error code but that could be adjusted.
> >
> >> That feels like it would have had the same theoretical benefits
> >> without the breakage that this change caused.
> >>
> > I am willing to experiment with this more but it can break
> > applications.
> >
> >>> But the reality is, apparmor won't be able to achieve equivalent
> >>> mediation without new hooks or at least more mount context passed
> >>> into the existing hook. That to is being looked at but won't be
> >>> is even further out.
> >>
> >> That doesn't sound encouraging as far as getting a suitable fix to our
> >> users...
> >>
> > If by suitable fix you mean equivalence of mediation between the
> > old and new interface, not in the short term.
> >
> >>
> >> Is there even a way in apparmor policies to cleanly prevent the use of
> >> the new mount API (return ENOSYS back to userspace)?
> >
> > Its possible, it will take another patch or two kernel side for this
> > case. We could even add a boolean and make it so you can apply mount
> > rules specifically only to the old or new interface.
> >
> >> We can obviously do this through a separate seccomp filter, but not
> >> everyone is using seccomp...
> >>
> >> St=C3=A9phane
