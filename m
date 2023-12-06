Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stgraber.org header.i=@stgraber.org header.b="NtSWf8FC"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF71B6
	for <linux-security-module@vger.kernel.org>; Tue,  5 Dec 2023 18:18:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca09601127so34278671fa.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 Dec 2023 18:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stgraber.org; s=google; t=1701829096; x=1702433896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILoS/WrORO+k4c54D4qrsiyw7xzH+3UvNRBbMK2xOP8=;
        b=NtSWf8FCL6kGgJU1hZOOjieKCqib0IL7gcWTzLwzJ3NOGF7MeD6IjxsnCGidMesYqx
         2EpPs/WM49LI44/w84zVQov6zBJ+daUqUW1P6szl8Rkr775DD/XR2ddgoIegALKeJaB0
         OF1xVpeQjv6WY5Gm+xynqi2jRiJCQ6+ubfedM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701829096; x=1702433896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILoS/WrORO+k4c54D4qrsiyw7xzH+3UvNRBbMK2xOP8=;
        b=nUO7I98xeLAQ9+kdODCR9f9JiCPA52+lyIHNs8W+l0QZTDFlUqWQbsX318RPGkcFDc
         G90BTgdil2k4PqvsJD20zCYSXQHRAHlH2X7XlAexDo1LAwjEwQNxAZUZBq4PSMBfb8Ql
         l+oNkF01c9/DqFejaeLEUPM1yvP1UjcoD8QFvLGRcoJ47Vyzflxab0L6m54738G1xeg+
         qs7lLGrjZTDztJWGLQZeAONjjCmGuH934fXX6aR2WdM6bgTx058Z4m2MXuBBYTK/3dh2
         O2KHNaY1cBmlWOhFNEoZXJ+2FCbpfCqfJNd5GU7SFtStI7aCvjk1Pih4Mk75Wj0IVyf4
         oW3g==
X-Gm-Message-State: AOJu0YwrvzpBrgZTnT+7l+gUmQyvwzdBAotUDN1cw0nEDZ2pM2ynmXEh
	4kzfSnBlm6E00E5xctgSKWkGwlwLhw3g/9qWHcYeOw==
X-Google-Smtp-Source: AGHT+IG4OlCdXHKgKUivbyBOZWRGKxeps1HY4ID6RkDmpQQNVPOmcFDBisDwb3XZtxZMy/qTcFmW98T6oRbVrXf1WeM=
X-Received: by 2002:a2e:7009:0:b0:2ca:19f9:fa5c with SMTP id
 l9-20020a2e7009000000b002ca19f9fa5cmr91106ljc.46.1701829095262; Tue, 05 Dec
 2023 18:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+enf=sWQ+-YP+uj9XfN_ykDsK=CYFFa35aPpeuS9B6qyLkjtg@mail.gmail.com>
 <582eb2e9-ce80-4f96-a4bc-bef1a508e0ab@canonical.com> <CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com>
 <fa2124b9-18c1-49b0-b390-398c2dde3fcf@canonical.com> <68c166b8-5b4d-4612-8042-1dee3334385b@leemhuis.info>
 <CA+enf=u5RhfTXR-xSGXeGZ+NcV7iu4NughBZRFq-kwRuV3A5eA@mail.gmail.com> <3d17c8c3-6558-4847-b123-4dbe1a1b0763@canonical.com>
In-Reply-To: <3d17c8c3-6558-4847-b123-4dbe1a1b0763@canonical.com>
From: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Date: Tue, 5 Dec 2023 21:18:04 -0500
Message-ID: <CA+enf=uzHAK3KEisZS3QfuUOMG_ZiFwyJGfP+5cyWB0-mdDQOg@mail.gmail.com>
Subject: Re: Apparmor move_mount mediation breaks mount tool in containers
To: John Johansen <john.johansen@canonical.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Mihalicyn <alexander@mihalicyn.com>, "paul@paul-moore.com" <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:55=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 12/4/23 22:57, St=C3=A9phane Graber wrote:
> > On Mon, Dec 4, 2023 at 9:20=E2=80=AFAM Linux regression tracking (Thors=
ten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> On 04.12.23 14:14, John Johansen wrote:
> >>> On 12/3/23 17:34, St=C3=A9phane Graber wrote:
> >>
> >> Side note: St=C3=A9phane, thx for CCing the regressions list.
> >>
> >>>> On Sun, Dec 3, 2023 at 8:21=E2=80=AFPM John Johansen
> >>>> <john.johansen@canonical.com> wrote:
> >>>>> On 12/2/23 17:20, St=C3=A9phane Graber wrote:
> >>>>>>
> >>>>>> Upstream commit 157a3537d6bc28ceb9a11fc8cb67f2152d860146 which jus=
t
> >>>>>> landed in 6.6.3 stable as 96af45154a0be30485ad07f70f852b1456cb13d7=
 is
> >>>>>> blocking new mounts for all LXC, LXD and Incus users (at least) on
> >>>>>> distributions using the newer version of util-linux.
> >>>>>>
> >>>>>> That's because for a simple mount like "mount -t tmpfs tmpfs /tmp"=
,
> >>>>>> the new mount command now performs:
> >>>>>> ```
> >>>>>> fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) =3D 0
> >>>>>> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) =3D 0
> >>>>>> fsmount(3, FSMOUNT_CLOEXEC, 0)          =3D 4
> >>>>>> statx(4, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_MNT_ID,
> >>>>>> {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID,
> >>>>>> stx_attributes=3DSTATX_ATTR_MOUNT_ROOT, stx_mode=3DS_IFDIR|S_ISVTX=
|0777,
> >>>>>> stx_size=3D40, ...}) =3D 0
> >>>>>> move_mount(4, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH) =3D 0
> >>>>>> ```
> >>>>>>
> >>>>>> That last call to "move_mount" is incorrectly interpreted by AppAr=
mor
> >>>>>> as an attempt to move-mount "/" to "/mnt" rather than as a new mou=
nt
> >>>>>> being created, this therefore results in:
> >>>>>> ```
> >>>>>> Dec 03 01:05:03 kernel-test kernel: audit: type=3D1400
> >>>>>> audit(1701565503.599:34): apparmor=3D"DENIED" operation=3D"mount"
> >>>>>> class=3D"mount" info=3D"failed perms check" error=3D-13
> >>>>>> profile=3D"incus-a_</var/lib/incus>" name=3D"/tmp/" pid=3D2190 com=
m=3D"mount"
> >>>>>> srcname=3D"/" flags=3D"rw, move"
> >>>>>> ```
> >>>>>>
> >>>>>> Note that the flags here show "move", the fstype isn't even set an=
d
> >>>>>> the source path at srcname incorrectly shows "/".
> >>>>>>
> >>>>>> This operation therefore trips any container manager which has an
> >>>>>> apparmor security policy preventing arbitrary move-mount (as those
> >>>>>> could be used to bypass other apparmor path based policies).
> >>>>>>
> >>>>>>
> >>>>>> The way I see it, the current mediation support effectively breaks=
 any
> >>>>>> attempt at mediating mounts in a useful way in apparmor as it's no=
w
> >>>>>> impossible to mediate new mounts based on their fstype or even
> >>>>>> distinguish them from a move-mount operation.
> >>>>>>
> >>>>> Indeed it is a far from good solution. It is a stop gap.
> >>>>>>
> >>>>>> I don't know if this warrants pulling the mediation patch out of
> >>>>>> stable (and out of linus' tree), obviously doing that would
> >>>>>> reintroduce that hole in mount coverage, but at the same time, the
> >>>>>> current coverage is broken enough that our only alternative is to
> >>>>>> effectively allow all mounts, making the current mediation useless=
.
> >>>>>
> >>>>> pulling it effectively means ALL applications by-pass mediation, th=
e
> >>>>> alternative is to block all applications from using the move_mount
> >>>>> system call as part of mediation. Which might have been acceptable
> >>>>> as a stop gap when the syscall first landed but not now.
> >>>>
> >>>> Pulling it from the stable branch may still make sense, you now have
> >>>> folks who are updating to get actual bugfixes and end up with broken
> >>>> containers, that doesn't exactly seem like a good outcome...
> >>>
> >>> I will defer such a decision to the maintainers the stable trees. I
> >>> can see arguments either way.
> >>
> >> FWIW, Greg usually does not revert a backported change if the change
> >> causes the same problem to happen with mainline, as then it should be
> >> fixed there as well. Which is normally the right thing to do, as Linus
> >> wants people to be able to upgrade to new kernels without having them =
to
> >> upgrade anything else (firmware, anything in userland incl. apparmor
> >> policies).
> >>
> >> So normally this whole issue afaics would be "157a3537d6bc28 needs to =
be
> >> fixed in mainline (if nothing else helps with a revert), and that fix
> >> then needs to be backported to the various stable trees".
> >>
> >> It obviously is more complicated because that commit apparently fixes =
a
> >> security vulnerability. But even under such circumstances Linus afaik
> >> wants us to do everything possible to avoid breaking peoples workflows=
.
> >> Which is why I wonder if there is a more elegant solution here
> >> somewhere. I doubt that the answer is yes, but I'll ask the following
> >> anyway: Would a kernel config option that distros could set when they
> >> updated their Apparmor policies help here? Or something in sysfs?
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >
> > So there are a few different scenarios here:
> >
> > 1) Distribution shipping application specific profiles that were
> > developed back when the new VFS mount API wasn't around, those
> > profiles allow the specific mount calls made by the application. The
> > application has since moved on to using the VFS mount API and thanks
> > to the lack of apparmor coverage, things have kept on working fine.
> > Now when the distro pulls this bugfix, the application will now fail
> > to perform the mount. Apparmor returns EACCESS which doesn't cause a
> > fallback to the old mount API but instead a straight up error returned
> > to the user. ENOSYS would usually be handled properly.
> >
> I am not opposed to conditionally returning ENOSYS. I also have no doubt
> that doing so would break fewer applications, it will still break some.
> As I said I will look into doing that

Thanks, that would certainly be a much better stop gap measure until
such time as the mount API can properly be mediated by AppArmor.

> > 2) All the container managers out there which use AppArmor as a safety
> > net to block mostly misbehaving or misconfigured software. Those
> > policies are not meant to be water tight to begin with (and due to the
> > nature of containers, they really can't be). But they do catch a lot
> > and while not an actual security barrier, they certainly prevent a lot
> > of accidents. Unfortunately with the new mediation in place, the only
> > real way to operate moving forward is to not mediate mounts at all as
> > mediation of the new VFS API leads to just about everything getting
> > denied and apparmor doesn't provide a way to separately mediate the
> > old and new mount APIs.
> >
> atm no, I am working on a conditional for detached mounts. I am not
> convinced we should completely separate move_mount() mediation for
> attached mounts.
>
> But to use any of that you will need a new apparmor userspace to
> support it. LXD is using the mounts as a behavioral/advisory catch, so
> allowing an unmediated move_mount() is not the end of the world. Apparmor
> still needs to be able to mediate mounts for applications that aren't
> containers and do need a tighter barrier.
>
> The reality with the new mount api is that atm we can only mediate
> move_mount(), but the new mount api does add a twist with the whole
> detached mounts. The only way to support that on older releases is
> using a very generic mount rule.
>
> New userspaces can pick up more. Leaving move_mount() unmediated even
> for older releases really isn't an appealing option. New kernels
> get pulled back and used on old releases all the time.
>
> > 3) A system where apparmor is used to effectively prevent any mounting
> > whatsoever, where the policy is now being bypassed by simply using the
> > new VFS API. Such a system would also need to not be using Seccomp in
> > combination with Apparmor as blocking the new VFS API syscalls would
> > avoid the issue.
> >
> sure
>
> >
> > I suspect 3) is what John is hinting at in this thread. I could
> > certainly see this bug be used to bypass the snapd mount restrictions
> > for example, though snapd also generates seccomp policies, so just
> > blocking the new VFS API would be a much simpler fix there.
> >
> I am concerned about more than the snapd case, yes snapd could and
> should use seccomp, but apparmor should be able to stand on its own
> for other cases.
>
> > I have no idea how common 1) is, but it looks like we're about to find
> > out soon and that has potential for some very "interesting" bug
> > reports as mount related errors are usually not the easiest to
> > understand and LSMs make them so much worse.
> >
> unfortunately that is always the case when fixing a mediation regression.
> This one sat way too long that doesn't mean it shouldn't get fixed.
>
> Overall though, I think lxd/incus is probably the major one. Most people
> are running targeted policies and have left most of the stuff doing
> mounts unconfined.

We did some research with Aleksa last night and that does seem to be
true for the profiles we could find.

However there is a bit of a catch that Docker, Kubernetes, ... pretty
much all the application container options do support using AppArmor
but don't provide advanced profiles, instead they put the burden on
the user to attach profiles to specific containers.

I have no idea how many people actually do that and since they are
individually crafted profiles by those users, we have no idea what may
be in there and whether they got broken by this change.

> > As for 2), as it stands, we're going to have to effectively turn off
> > any of the mount related safety nets we had in place in LXC, Incus and
> > likely most other container runtimes out there to handle this. The
> > usual issue with doing that kind of heavy hammer change is that once
> > it's done, it will take a long time to undo it. That is, once AppArmor
> > is actually capable of mediating the way it's supposed to, a lot of
> > the profiles will have been changed to just blanket allow all mounts
> > and they're only ever going to be changed once we're confident that
> > the vast majority of our users are running a kernel with the fixed
> > logic.
> >
> I am well aware of it. I fall on the side of leaving this completely
> unmediated is slightly worse, but I can understand why someone
> would choose to leave this unmediated.
>
> > I guess some of that could be handled better if there was a way to
> > detect the current broken mediation of the new mount API and then
> > later again, detect that the kernel now has working mediation,
> > allowing for those container managers to generate accurate profile
> > rather than have to go for the "safest" option (as far as keeping
> > users running) and just keep allowing everything.
> >
> > John, is there any such detection mechanism currently present that
> > could be used by userspace to better handle this situation?
> >
> sadly not for the move_mount() patch, it is however a one line patch
>
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 7465c39ad1bc..6cd52767cfeb 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2373,6 +2373,7 @@ static struct aa_sfs_entry aa_sfs_entry_policy[] =
=3D {
>
>   static struct aa_sfs_entry aa_sfs_entry_mount[] =3D {
>         AA_SFS_FILE_STRING("mask", "mount umount pivot_root"),
> +       AA_SFS_FILE_STRING(move_mount, "detached"),
>         { }
>   };
>
> or similar. That I could send out today.

I think that'd be useful to have as something that can be used to
detect this behavior from userspace and have the affected code turn
off mount mediation if that's the case.

> it would surfaced the via the regular securityfs/apparmor interface as
> /sys/kernel/security/apparmor/features/mount/move_mount

> I could also get you a simple conditional patch around returning ENOSYS
> to start testing, so that we could potentially try sending a final versio=
n
> of that patch up next week.

That'd be good. I feel that if this change had come with the ENOSYS
behavior, I wouldn't have noticed it at all.
With the new mount API being still pretty fresh, I'm not aware of any
userspace which today relies exclusively on it, so having it be
effectively disabled until such time as you can mediate it properly
shouldn't really break anyone (always hard to know, but sure would
break a lot less cases than the current change).

One catch though from my testing with seccomp, to make this work, you
need to have fsmount return ENOSYS, if you only have move_mount return
ENOSYS, it's too late and libmount just returns the failure to the
user rather than go down the old mount API code path.

> > Overall, this still feels very rushed and broken to me. I understand
> > that being able to trivially bypass AppArmor mount rules isn't great,
> > but shipping code that makes the vast majority of said rules useless
> > doesn't really feel like such an improvement. It's effectively turning
> > what was a reasonably flexible policy engine around mount calls, into
> > a binary switch to either allow everything or block everything.
> >
> I get what you are saying. The other side of the coin is oh look apparmor
> isn't mediating mount if I just do this ...

Sure, but I suspect we could have avoided a bunch of pain if we had a
chat around this change, had an opportunity to test it ahead of time.
At the very least, we'd have had the flag file introduced from the
start and hopefully some better handling like some kind of ENOSYS
option.

> > We at the very least need a way to check whether we're dealing with
> > this known broken state so that any change that's made to userspace
> > can be made condition on this, ensuring that once mediation actually
> > works as intended, those policies also go back to the way they're
> > supposed to be.
> >
> agreed. That really should have been part of the patch to begin with.

St=C3=A9phane
