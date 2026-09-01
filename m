Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDC17A305;
	Tue,  1 Sep 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265726; cv=none; b=s43dl1+yoaWlJm5yX7jNFy63Q3ebMRSobb8LzqwCI0ZG+fR01OsHyoRemZlrc7F+MyLPtA6HQXW8+WSIxN/caVNnbiJCc1w2GNXiahUqQ20M7h0UK/ri5bq0eshjH9ggTXForKihlcgWHL/OqlxrgGHbI8+bJoFg2puCaCYQUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265726; c=relaxed/simple;
	bh=PerxyjgHdgFLCGe6anVVmM0+fGvFbzemlvUY3sCt7/0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RveQ9Bt4Vgrvg3d9Plg5zRQowoE8jmeuu/Vvzet7GNpUX0KaYxw6uvgfTaFRBOWPEXENxmp+I73D/fVDFjCF9yVsT+7P+uI309hraXwaS40UwUk4E7oyL36UIcaGzZ/S+yESE3GBrJtdqVZG6M6PbS36TSLohupoHChXYUaGtkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVkAMzKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVkAMzKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD631F000E9;
	Tue,  1 Sep 2026 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788265725;
	bh=feBwdgTOoqU00JNK5NZX1JztfFCR+yBs8goH1Er6+l4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TVkAMzKMefyWzKKgV42vXkIkX+gvZhqC+trJKS2rpvSEHPYjjaBrrh9GRvRfE+kBW
	 txrRKAxCL++EYX6Sx9GdKZ4eR51gdzArdOv+EN7+21uun/27sR0GjBo9H+pHzHbKbB
	 8CCzMcMEwfM7d7eXUpTA+o6ribMBwEdLta8oBiKNdWKIDfcD9i/g8yWSy9LdQfOEL8
	 fDwqoKKSkxXrFSovqQSZv/UXOvoGBjoH0BOmN0zKTdEF713aeCom2OSLRraJyiXPhI
	 OFe3Y3PbPyjWwaQJjvoSHB3rqbNVYiI9xIxIn85wy8gYBNW9Ot/ql764ujZOmQzyn2
	 3E9uRsGdFkuRA==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] lsm: expose mount idmaps to inode hooks
From: Christian Brauner <brauner@kernel.org>
To: Daan De Meyer <daan@amutable.com>
Cc: brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, 
 viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260824-lsm-mount-idmaps-v1-0-0414a9641c85@amutable.com>
References: <20260824-lsm-mount-idmaps-v1-0-0414a9641c85@amutable.com>
Date: Tue, 01 Sep 2026 14:28:37 +0200
Message-Id: <20260901-tastsinn-beiwohnen-planlos-111784e32433@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PerxyjgHdgFLCGe6anVVmM0+fGvFbzemlvUY3sCt7/0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNO/Jjv7PtpgLhW4tO3AuvUg+3/Lt6LtNhgZrv3semM
 03zOun1paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidf8YGQ4VqKXyiiTcXNwl
 8U44JzY+6iCfj/KqZ0WX69fcetYykZ3hr3BMxv7Csr4899C22vWrGo+vatWZ4TrtVIfjLWf1oJX
 SHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> OverlayFS performs upper-layer operations through inode-based security
> hooks. Those hooks receive the upper inode and dentry, but not the mount
> idmap used by the VFS operation.
> 
> The security layer cannot distinguish an identity-mapped upper from an
> idmapped one or make the same ownership decision as the VFS. The VFS
> layer already passes the idmap down into all relevant inode operations
> so this just brings the security hooks to parity.

Yes, I didn't do it initially but this has been on my ToDo for quite a while.
Thanks for doing this.

> 
> So pass the mount idmap through the create, link, symlink, mkdir, mknod,
> and permission hooks. Update the in-tree security implementations and
> non-VFS callers accordingly.
> 
> systemd has been shipping systemd-nsresourced for quite a while now. It
> relies on inode and path hooks to perform ownership checks using a bpf lsm.
> To make this actually secure we need to be able to calculate the on-disk
> ownership from the idmap.

All looks good to me, but you need to resend with your SoB added.
I think you dropped this because systemd doesn't require it.

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 

