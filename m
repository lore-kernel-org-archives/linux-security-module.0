Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138DC48A2C6;
	Wed,  9 Sep 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953300; cv=none; b=rKtPBZJ/3iAd3wblsUMkLvGfUWX5XmlMNViN2E49+JFylTQWX1efdZnvOPSx9wYHZwI85tm5Yo6CENzOKh9oUxxHWZebTTkjVU1Ferbulsj9t5STZQZMxQDFVJFBjMWkEmKDTfKpbDtz2m21WY4Bo6zf+tIsnEPbLMQQmjxXS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953300; c=relaxed/simple;
	bh=QVamOOMk3BPX58RfnZC1arhvfIjv3zgYenGB7wPdsbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b31xXKnRQNDz+FA4g0UBTntSed/aOKo5m9TW7mFrWlKwYwLWgxju++3LWoRk4JH+BfbcrTmW0fLlqpb/yYEejz+feLoTRfMQNIArEe1capauWaHpKTl0HNihaKD89Dim9eVXsix9Ij8l1C1BD1k4r7nO80oKMmuEmJRizZNDxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXJI9p2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXJI9p2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAA91F00A3D;
	Wed,  9 Sep 2026 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953299;
	bh=j17h6KRQ71DOKHe5HbsIWrPqIzBnLjkU7JRtdQFf8P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lXJI9p2zO/vxjji4Pf57L2VDsA9uaSee2Re2yDtxf4Z5PoOvNPpzKmchx/EziO5kP
	 KjJnE7YY+z/SB3qB9MjsIV4lSR0a8r9PmrfG8kBW6AegVMRl3fpiXT6Hz1BTSuKRIv
	 aScTVKuTq4E0MmMhrcXJ/Jn2+fInKWjfayviwlZorXMgrXGDqnJeSu5azDowdwzefX
	 SQ3BhAH2TVB16pqTfvueEtv7NsJ5Nl10G3PS4ddXbLZ8xD+wzmoEV0jFxbSQIfxkcl
	 WsDhao8WolO7q/sR8WCm6xWN0lsy7tgyWc/AtM3ENRAX9ono06P5pfbc6C+P4ItoqQ
	 7VY22cnclJWAw==
Date: Wed, 9 Sep 2026 13:28:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: daan@amutable.com
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 0/2] lsm: expose mount idmaps to inode hooks
Message-ID: <20260909-gutsbetrieb-satzreif-flehen-b9e85ff627ec@brauner>
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>

On Fri, Sep 04, 2026 at 04:48:54PM +0200, Daan De Meyer via B4 Relay wrote:
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
> 
> ---

Fine by me. @Paul, even if you change the description or whatever. Keep
my RvB, please.

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
