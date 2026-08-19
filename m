Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79F43B3FD;
	Wed, 19 Aug 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131370; cv=none; b=hlN3Ug5vFQ/M78OjV9pKE/0Znm8gS7M7Hm++gN+EJy/1KUScbnBqp8cNzSvkDI8xSnvSqBK8XWC8ka6mLLfM5b89vfmQ7/x2f0VkPjdDuU60gNeNZ/hJa0myHyAK1Zp/JmuGvX1RrA7OdOsERtBUrPPN/ebS20mRkTSlTdytZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131370; c=relaxed/simple;
	bh=LGal0UEavLHUU1VOslqasVcuNYc9my7rLbeNtfNMh8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNQ2AJxc2bK7jJMwlVZ7t2v9+lsZs0j4645IFgu3BZuLCAquWxtpMsAw7m8nOHkE4MQ9vK/ctXcQ37ah1E9rAYmG1gyww5XDzyrHforphIpZ8ItNMC9fPkoGAFSrPljFvjUeFY0Fhh+j9QeMdr7pyEi4o52Rt7dmuYiAkpHJaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qk3NWks4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qk3NWks4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J5RssR63uARUV1vLkp2EGzmcfBQHFIQuycSjO59ViL0=; b=qk3NWks4Gx+9ZWXvfUZycMOV+p
	AzYQhTLaU64zlmmphdPt62orSNkETQj4UlpbLgPz89iE31ADd1k6+FQ65fReiBb0kCmcznmWBpfSG
	+TRXMZLJjAdLcp6Y22p25R6WGQHO3dUQ/qnFnxnzi4uL6KxmQbuUVlLR9Wcnsn70EyBEfKhGB9vwX
	EillIVkNcQ4aC8g4wRVzDtiUBCp2EdopThdTra1gOpu8qla2fForspKYsrqhecMHzjlZ2hhnWr1kV
	RX59VtQjvBdnFZBE5QlzmujOrTLBXS7dAG9z9Jm9Bl/hBZEpLIGeoi/bkKFmecDmjN2GMuUraJo1o
	fgkP2JCA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwcUl-009gkm-38;
	Wed, 19 Aug 2026 09:22:04 +0000
Date: Wed, 19 Aug 2026 02:21:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] configfs: move CONFIGFS_MAGIC definition to magic.h
Message-ID: <aoV1hRKX1yb5vKrW@gmail.com>
References: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
 <20260818-configfs-v1-1-a2329043cf86@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-configfs-v1-1-a2329043cf86@cloudflare.com>
X-Debian-User: leitao

On Tue, Aug 18, 2026 at 02:35:15PM -0500, Frederick Lawler wrote:
> IMA shouldn't measure or appraise configfs, but currently does because
> it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> magic.h to expose the file system's magic to IMA, as well as other userland
> applications.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

> +#define CONFIGFS_MAGIC		0x62656570	/* some random number */

0x62656570 is ASCII "beep", I didn't know that :-)
