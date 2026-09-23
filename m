Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41157D22D
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196690; cv=pass; b=dtTtrdDLb66oHRzRkD5lhgF1+1PP9+s1uaAIgK14Ez1nr3081rUKTS1JNf07VtIEWZt6VYfOgBRCoaTy8TIEaZcnROZQJF7xZRjxfes89fxqpNMCbo+bf/H30bEpgg1HiXl9Uqq3Thn+Nr+cv5P9EG8TS9tUUXp3Iw4VXDqCfpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196690; c=relaxed/simple;
	bh=5RYTLQDvsY6XpN1VQbrbqg1sz7KWIZfN0YLEprJU4uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gckgeTIa/oAuk1PDzj+hhiDME4DjOADbtYzBME4x7peZ6FSsdajw8Fch2JKHqodVBDF+8U2wlhN9eQrFTrOVsg+86hy6Z4yETwKQGM1F+m+G5a/OEpqAhd8nPlcgz5VEeMOoEcKc2DlGFf8EJFr6cLH5he6g94Q5WX8FDctRMUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jy9s/CTR; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jy9s/CTR"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so664974a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 13:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790196684; cv=none;
        d=google.com; s=arc-20260327;
        b=HbrNq7ypKBs5l27gMwM8Ux5zcl6vvnDQJgvnOnga7iNlzVGepZ56WNcoBldUrs58Hd
         mYy1GHwZUEltR40j63vdBTtBc+HxfbjvQd5qb1KP/JtvWOG/Xthv3S2paGpBfEXE40x7
         jQqzEiGpYn5glczcmA3f7Ep9PKZXmPhtCWUs+xeyY8H+0FVbp8VF0BfgKi+t9QI6OqYl
         fOGNwb/H/jhL8LHU95E7tKrSe4Na0qRUnT9WPhSQEw4oT1ELnOpQi5SdhLHrpbQQpszc
         j2xuNmJd+5uk2OGAChzZK9NEJscLM03o/VXte8prq+A5ywiYeWARJs6M33nLlejB5ikW
         Wr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UNvgCnr3l8BtKs/YQ4o409r9tmPanak9V4c7Oc/FOcE=;
        fh=jeRDeggCGnY2UajpjwNi6segZu079v+bsNm1GTwCl8k=;
        b=XNMaL6njqGmd+NQfjWHNMLa2o1dAx8EzjZJDXYFueNLpJIGSEDBL+MZLRC58gH3aW7
         nXXRBA4VVOTPDb88djsQi6ju+D3gxUFaAhky0QK3Epx42qkpk2/qkgRXlDMJvW82QKAh
         nk5R7sw8+4FROtP8T0Bo3iVan94me23xDOX1jtlQ1fkTylThHDKA3lvQO/VqaiceXUn1
         GuN0xGZxdkmJUtorBoBNrQCdwks0hklb8INRExqQAVXcMBRjrxgM3O2FxtfWV745AP6o
         jWrlMf098Ifrs4ZI7hGOgk1dd1gJVqaGxH2ZLI2dRv9Zx/mxkqAWOBGP2TZK3fKrrEzg
         IBOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790196684; x=1790801484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UNvgCnr3l8BtKs/YQ4o409r9tmPanak9V4c7Oc/FOcE=;
        b=Jy9s/CTRgYkWy45lZFpncBbKX8Sd/nTIvGyjYjanbW7ikSfVqw8ik5En4HWNPwurQE
         gZLY07EzDW41AOBEcY8zzByVGoS/0e1wuD67qoHF5Z0EmXtNyy5NDocRHSxszpBCNbl2
         I+mdYAr/Wb/9focNs3Uj4ppYm+TcJmP8qUXVRuvXvzjtyT0KTbXySBugKdeomMwnUc2Z
         N0JVZkJuF4whi4wThkpNHkeCukHWiffsvhpICjsCG3YPS06j1nqAsFhJyQlDo7Wvl0lx
         vmXqZfjO8UMXIxBehvuMT6kVaHG0Bvb+2JZRcxoDyqVcofLyfWtZKQDrySK+/5oAsLmx
         33Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196684; x=1790801484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNvgCnr3l8BtKs/YQ4o409r9tmPanak9V4c7Oc/FOcE=;
        b=GvzNRU/ovS1BvgKUY60aWOYgkX1i5ICYKqErD8lquuzkWO5qKo1/D40Tx/t+FhMgI+
         mE5vRVnk8rETR3iH8UpVgoDuIt5eiglhIr8/GcBkir7k2adD9jAjG4eyu7eLbFAlfOFl
         xAOjt9En27bLWC4aWXzPZ1vjwC7owScHlA7P2/rYrqlhz0UT1AWJKIWiS8oMgXynaRNv
         BIUcT8749cmi94yawinDExU1VwbdRZ0Vc0JYTGtzUu0H2zdRtfY7CjMLAaSi8MSlKU4Y
         u0D7toplGflpO+/HIOYedRJIbdMc0G1g5x0k2zak73I6RzEBam9QfzfvMpfhWaV8Meb7
         6SqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaWn2XSqxAS6v8Y+YDYWzZZJtvt6WQcAgXPbri05aDfSfEoX3yYcpXJ4m2ybCq63hB/2KnYtaKp//ZjI312+B2O2Y3p7s=@vger.kernel.org
X-Gm-Message-State: AFuF++mdqvdgMdctSr4eDHEQlPMIPGO/J56kT5g1UmsNtVgau7+WgKRe
	BbJUT5xKldtBhlNkEzhqk3NBmNZ5gly05Vcfy9PybjT7SzelgR4qFjgbjI0c0rFWSggn4LRZqWk
	XrDSOz1G/ZbsQgjpND8rfrckAoruyLAEHXtWDi0q8
X-Gm-Gg: AYBFou2XBuI3LhW4xi2f4doE3/ULfQEcgeNl1FwMtPDHo2oRkHgZ7bfeIBcx3fJgQxh
	aNP/ASdUrG6Xwgea2jVCb/ovsLffPTh9dyOH6aNPXpFQR5fbr1IVmDVA1HQaNtoVNqggiV41Xne
	JDRH1j6xChLCIKwJ45JoDvTqqk2V64zHQ4CMtG6RN2wRspk3NB7f9GXowUtdBxihOMFU9RhYHXK
	wdsoOGwjz3BsPNZqzirt3eu8A2vh2A4szYIIrZNlbKKPxKTodg0XNzjKRGT/FZjGIFVcoblnoz7
	eiUVKY+RzHWIBa0ZUjJZtui3HlFclZdD38SE2+zPlCqO5k0aqqGzrhXpQ6vQd+79IVgM98PUTQe
	NB2K/4yu4E/U=
X-Received: by 2002:a17:90b:1c8a:b0:39e:6c69:34d5 with SMTP id
 98e67ed59e1d1-3a098e900e7mr270237a91.57.1790196684349; Wed, 23 Sep 2026
 13:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com> <04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net>
In-Reply-To: <04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 16:51:12 -0400
X-Gm-Features: AclHuK-ar601PMbFiiED6HOc4D8YTbyv-_xOHtq1GJMVDRpo26gCnJ7sdFUEhlo
Message-ID: <CAHC9VhQ9NvAn=+58weX8to-AaxsOQn9gck9Ztmrw86aemhWWsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: dwindsor@gmail.com, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:11=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 9/23/26 6:57 PM, Paul Moore wrote:
> > On Tue, Sep 15, 2026 at 11:07=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >> From: David Windsor <dwindsor@gmail.com>
> >>
> >> Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in ext=
ended
> >> attributes. For these LSMs, atomic labeling during inode creation is
> >> critical: if the inode becomes accessible before its xattr is set, it =
is
> >> briefly unlabeled, which can disrupt LSMs making policy decisions base=
d
> >> on file labels. Existing LSMs solve this by setting xattrs in the
> >> inode_init_security hook, which runs before the inode becomes accessib=
le.
> >> BPF LSM programs currently lack this capability because the hook uses =
an
> >> output parameter (xattr_count) that BPF programs cannot write to, and
> >> existing kfuncs like bpf_set_dentry_xattr() require a dentry that isn'=
t
> >> available until after the inode is accessible.
> >>
> >> Add a bpf_inode_init_xattr() kfunc that takes the hook's own xattrs an=
d
> >> xattr_count arguments, passed through from the program's context, and
> >> claims a slot via lsm_get_xattr_slot() on the program's behalf. The
> >> xattr_count output argument is exposed to inode_init_security programs
> >> as trusted read-only memory, so programs can pass it to the kfunc but
> >> cannot modify the count themselves.
> >>
> >> Reserve BPF_LSM_INODE_INIT_XATTRS slots in bpf_lsm_blob_sizes the way
> >> every other xattr-providing LSM does, for the life of the kernel. The
> >> framework keys the collection off the reserved slot count, so a kernel
> >> built with CONFIG_BPF_LSM=3Dy now allocates the xattr array on every i=
node
> >> creation, whether or not a program sits on the hook.
> >>
> >> Give the hook a strong prototype in bpf_lsm_proto.c so that its qstr a=
nd
> >> xattrs arguments are marked __nullable. Both can be NULL for some call=
ers.
> >> Without the annotation the verifier otherwise hands the program a trus=
ted
> >> non-NULL pointer which it dereferences. Also, keep the hook out of the
> >> sleepable set. inode_init_security runs inside the transaction creatin=
g
> >> the inode, with a journal handle held on ext4 and btrfs and the parent=
's
> >> i_rwsem down, which is why everything on the path allocates GFP_NOFS.
> >>
> >> Signed-off-by: David Windsor <dwindsor@gmail.com>
> >> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   fs/bpf_fs_kfuncs.c         | 99 ++++++++++++++++++++++++++++++++++++=
++
> >>   include/linux/bpf_lsm.h    | 11 ++++-
> >>   kernel/bpf/bpf_lsm.c       | 22 ++++++++-
> >>   kernel/bpf/bpf_lsm_proto.c | 15 ++++++
> >>   security/bpf/hooks.c       |  1 +
> >>   5 files changed, 145 insertions(+), 3 deletions(-)
> >
> > @Daniel, you were CC'd on David's previous patches, so I'm guessing
> > you saw my objection[1], but just in case you hadn't please look at my
> > comments where I requested that David's proposed LSM kfunc be located
> > in security/bpf_lsm_kfuncs.c as opposed to fs/bpf_fs_kfuncs.c.  It
> > would be really nice if we could sort this out now and avoid having
> > this drag out or escalate.
>
> Paul, I reached out to David recently asking whether I could offer some
> help with the BPF bits, added some bug fixes and a lot more BPF selftests
> as I think the inode xattr init is valuable work and something we need as
> well. I just reread this whole thread below given its quite a while back
> and didn't follow in too much detail back then.. the location as it is is
> perfectly fine, I see no reason to change it, and I guess that makes thre=
e
> of us then including the VFS folks [0].

I didn't think there were any doubts that the BPF and VFS folks wanted
the kfunc in fs/bpf_fs_kfuncs.c, but I thought I made my objections
clear in the previous revisions.  While you've changed things slightly
from David's last patchset, essentially folding the proposed
security_lsmxattr_add() helper into the bpf_inode_init_xattr(), it
does appear that the basic purpose and context around the kfunc
remains the same: the proposed kfunc is called from a LSM
inode_init_security callback, it populates a LSM framework managed
buffer, and then when the LSM callback returns the LSM framework code
in security_inode_init_security() does the xattr init based on the
buffers populated by all of the configured LSMs (the BPF LSM as well
as others).  As there are no direct calls to the VFS layer in the
kfunc, but there are direct calls into LSM internal APIs (e.g.
lsm_get_xattr_slot(), as well as the LSM state and calling context
mentioned above, from my perspective this really does need to be
located in a LSM framework BPF kfunc file (e.g.
security/bpf_lsm_kfuncs.c).  I've mentioned several times in David's
previous postings that I'm happy to work with you and the BPF devs to
set that up.  If you are open to that let's sort it out now so we can
get everything in place before the merge window.  If that isn't
something you are able to do, that would also be good to know.

--=20
paul-moore.com
