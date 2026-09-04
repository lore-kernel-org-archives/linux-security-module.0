Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167622B594;
	Fri,  4 Sep 2026 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515167; cv=none; b=bjkEnCoKyhyag92uiB+iN2ARtoto2aaS0w7Q7BeIqxm4/wGi0n5v6pdLpA8tBjrYjijOpSUZGEW+BMPcXvFNDg9ROMryCIjE8WFl4sNjsF7ukVe9dVCg7O0C/WSLP3hrA982HB9YWk0JPDZbo9DdZhByTz0PwBsYZzYRmheqwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515167; c=relaxed/simple;
	bh=y+W6cVVaEnkRTOdwFi4xRLb3c62fXabFJStVd8BmSME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUdqXauARkuRNU1+Dktw/7TWyfYxbDLydT+e+WBiSzwhSJcBAoDPYF9ogHFIC+O1+g6gbqp7vZ6HFP5lzBPriiGftwZavAmuSAHKHGu45BkpBtAW0s/3+uDvr0sTaiebuBx35hyqoqu+gs9CqoGR3T8xDEf3kfXyE1tUvD8D8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4EvOSDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4EvOSDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AAF1F00A3E;
	Fri,  4 Sep 2026 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515165;
	bh=ql/zEvhDaAbMWrvIes2jE/AFR+S/Bqz5i+JybsRCF2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4EvOSDnY1f1hCKjYeEzO1U64Zil2K6bFmg7bpcDQtWiMrIgUth1JsCJVX0nhA8sy
	 ZU93ZjQeW4+yJfrVB1fifqbR945rgk4fQxGjF/PUtc/CaNdSUbCHTBYkcOim1zqF2S
	 i3x2WOjXLUtOJmOAyQPyHr26iK5AbORHF8JYoEe4KqqpkRAaRbqdIZ7qWxswLU4MHQ
	 Ip0kGj4KPD3EGqDi312EC2hVYp16hBYcWxu+HkwtBLDE1ah0j0lHuwGfoD6Lv23cAJ
	 BX1rrMLkgXo+q/HAfrrxuAKi3lTsbXn3ybJzLKnZLF8Ac8DkLqSwIKARfkA09Lgrhy
	 f16cS/Qi+PNpg==
Date: Fri, 4 Sep 2026 11:46:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: daan@amutable.com
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] lsm: expose mount idmaps to inode hooks
Message-ID: <20260904-kopfnicken-torpedieren-pumpwerk-18158dccbf4a@brauner>
References: <20260901-lsm-mount-idmaps-v2-1-3309b9d1eda2@amutable.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-lsm-mount-idmaps-v2-1-3309b9d1eda2@amutable.com>

On Tue, Sep 01, 2026 at 02:50:23PM +0200, Daan De Meyer via B4 Relay wrote:
> From: Daan De Meyer <daan@amutable.com>
> 
> OverlayFS performs upper-layer operations through inode-based security
> hooks. Those hooks receive the upper inode and dentry, but not the mount
> idmap used by the VFS operation. An LSM therefore cannot distinguish an
> identity-mapped upper from an idmapped one or make the same ownership
> decision as the VFS.
> 
> Pass the mount idmap through the create, link, symlink, mkdir, mknod, and
> permission hooks. Update the in-tree LSM implementations and non-VFS
> callers accordingly.
> 
> Extend the BPF LSM selftest to verify that both the identity idmap and an
> idmapped mount idmap reach each hook.
> 
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
> OverlayFS performs upper-layer operations through inode-based security
> hooks. Those hooks receive the upper inode and dentry, but not the mount
> idmap used by the VFS operation.
> 
> The security layer cannot distinguish an identity-mapped upper from an
> idmapped one or make the same ownership decision as the VFS. The VFS
> layer already passes the idmap down into all relevant inode operations
> so this just brings the security hooks to parity.
> 
> So pass the mount idmap through the create, link, symlink, mkdir, mknod,
> and permission hooks. Update the in-tree security implementations and
> non-VFS callers accordingly.
> 
> systemd has been shipping systemd-nsresourced for quite a while now. It
> relies on inode and path hooks to perform ownership checks using a bpf lsm.
> To make this actually secure we need to be able to calculate the on-disk
> ownership from the idmap.
> ---
> Changes in v2:
> - Squash the implementation and selftest into a single patch.
> - Add the missing Signed-off-by trailer.
> - Link to v1: https://patch.msgid.link/20260824-lsm-mount-idmaps-v1-0-0414a9641c85@amutable.com
> ---
>  fs/cachefiles/security.c                          |   4 +-
>  fs/namei.c                                        |  18 +-
>  include/linux/lsm_hook_defs.h                     |  23 +--
>  include/linux/security.h                          |  58 +++---
>  security/security.c                               |  40 ++--
>  security/selinux/hooks.c                          |  19 +-
>  security/smack/smack_lsm.c                        |   9 +-
>  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
>  9 files changed, 410 insertions(+), 71 deletions(-)

Oh, what happened to the earlier series? The first series did split
tests and so on correctly into a separate patch. This lumps test and
semantic changes together. We generally don't do this in the kernel. So
please do resend.
