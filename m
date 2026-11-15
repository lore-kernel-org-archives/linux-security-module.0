Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752299;
	b=meruXolTnK5Jgm/ukRjATqAZ90xekPEXZ/cTHqDkWjSz3M/MxvGolX/HA1yiSgwMsiW/
	 3oKGRXLUr7fzFpMCd9oLfUpj2QJKwZzI3ONAc/F2DbmA1DMYPRMwKaqUEicx6S0YutNww
	 hYEhDpVdTljreFXnJTJjeoGO5yySwBBEvHcJuZHWwSCWaEvWwQ5zMSru0/WCzj/uN0HEN
	 dV8Tc46TTvNTgkVu5PT28QqUZdFGNrQqIWmzB/y8WDNJsZYFnT/cMrtXsNZg2CAmFfdec
	 3AUYK83lokjtzhukWsqCXuFUm/oWDOGpD3sfDV9h9SPRqC+KoV/qeS8jXWsAs0HhtLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MSIEtI58igpSkC03ZSunkIyPCpxjJGmFBTOTFfPJaAY=;
	b=EBI1kTFDxYLf+PfMp4OyeNpnNKDxI6vHCsTcXpOVCqc9qN95eTGVYLBIrhJ3jMGc1cF6
	 b2jg64wqiy5qOcyYF3zM3n4dICZRnHUzFUgt2KDjEedhXg7qHqsJ3OGU+nSFL5/d78xG2
	 xVK3mlVaUNtpRr/XAtnkm+5ylfOLQ8dHgvpRnff1XqsNOaYbvr+qWd+Gyw5DPbWD76gKF
	 RNRJpT8JGYcaMB91WCAR9DHBSLZL17OXtIXxaskBIbLuvX8xg0agPV5yodzgfc5VeTmS8
	 u3UFiIetTqxARKwPMYBp72mpQq7YIZMQMb13Sa3ex2nPkGMkONL4rzk6yrr4ftuQ7tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaihiTx9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F92606A31A;
	Sun, 15 Nov 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaihiTx9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F3D1F000C4;
	Sun, 15 Nov 2026 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794752299;
	bh=MSIEtI58igpSkC03ZSunkIyPCpxjJGmFBTOTFfPJaAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaihiTx9MzRiQl4ssjwIOWuOQnwxBHZWiEFSMT3+M8Jz80d6+8xpYG97TN/cTGs2G
	 WYdm8pz7zAar41etMr+831psVY9i+HgE4mS2PEAk+IHgbMmvkMxPN4RH+uU5/IuQ2S
	 XEbs+nvT7rwrdos5pyOiDoIfEf2D5tSLc0Nz5MxHuaTgfRTVsMw/KsI5H6+Jecp1dP
	 RMDGzaNZsZA7xji8eXBBpMQblnEMso3385xY0XFNQzxGG+SC+9BVmUaJYPz0O6cZZW
	 mNSJhbrLAt8QQDlU49fdieIvcteFG9royl2EDk+bVkmRTn+nqnHboYoAkpK2vEHZ3I
	 sLd+x2p9XfNLA==
Message-ID: <sashiko-outbox-215574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] selftests/ftrace: add uprobe tests on overlayfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi" <mszeredi@redhat.com>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261115-work-ovl-d_real-v1-12-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-12-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:18:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests/ftrace: cleanup() in uprobe overlayfs test fails if
  event is enabled
- [Low] selftests/ftrace: uprobe overlayfs test misses tmpfs xattr skip
  and configs
--

commit cdef3f0121f6552797f32e8a89d02391a6081a77
Author: Christian Brauner <brauner@kernel.org>

selftests/ftrace: add uprobe tests on overlayfs

This commit adds an ftrace selftest that exercises creating and firing upro=
be
events on overlayfs metacopy files backed by a data-only layer.

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_up=
robe_overlayfs.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remo=
ve_uprobe_overlayfs.tc
> new file mode 100644
> index 0000000000000..a4351e6a3b181
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe_ov=
erlayfs.tc
> @@ -0,0 +1,92 @@
[ ... ]
> +cleanup() {
> +  echo > uprobe_events
> +  umount $OVL/merged 2> /dev/null || :
> +  umount $OVL 2> /dev/null || :
> +}
> +trap cleanup EXIT

[Severity: Low]
Does cleanup() fail to remove myevent and unmount the filesystems if the te=
st
exits while myevent is enabled?

ftracetest runs test scripts under set -e.  If executing $OVL/merged/sh fai=
ls
between enabling and disabling events/uprobes/myevent/enable, the EXIT trap
runs while myevent is still enabled.  Truncating uprobe_events then returns
-EBUSY from trace_uprobe_is_busy() and aborts cleanup() under set -e before
the umount commands run, leaving the uprobe registered and the overlayfs and
tmpfs mounts leaked.  Writing 0 to events/enable at the start of cleanup()
would avoid this.

> +
> +mkdir $OVL/lower $OVL/data $OVL/merged
> +
> +# A metacopy file whose data lives in the data-only layer.
> +REALBIN=3D`readlink -f /bin/sh`
> +cp $REALBIN $OVL/data/sh
> +truncate -s `stat -c %s $REALBIN` $OVL/lower/sh
> +chmod 755 $OVL/lower/sh
> +setfattr -n trusted.overlay.metacopy $OVL/lower/sh
> +setfattr -n trusted.overlay.redirect -v /sh $OVL/lower/sh

[Severity: Low]
Will this test fail instead of skipping with exit_unsupported when
CONFIG_TMPFS_XATTR is disabled?

tmpfs only supports trusted.* xattrs when CONFIG_TMPFS_XATTR is enabled, wh=
ich
defaults to n and is not selected by CONFIG_OVERLAY_FS.  Without it, setfat=
tr
on $OVL/lower/sh fails with EOPNOTSUPP and aborts the script under set -e.
Also, should CONFIG_OVERLAY_FS=3Dy and CONFIG_TMPFS_XATTR=3Dy be added to
tools/testing/selftests/ftrace/config?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D12
