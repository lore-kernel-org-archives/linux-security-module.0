Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F71CEE9F;
	Thu, 23 Jan 2025 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674453; cv=none; b=BcUKJilJ3wiHjejBAKcIHhTx4EqUBMafgCRvDTPDlUHmhdRskP90AM/84ounrBU9mUYYKlCFRehMj9CswivDO9MYFUtYsOyi5duhZEYtRRB0jQQYZqo9mVPqT/+b19n6kRSeVIrjdnP0hRStpuC64obUmJL7lqG28KEOGeKedAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674453; c=relaxed/simple;
	bh=Dl0ICc71HGR9i7d5TCOBBwkilSh45O7AoQ8vo4PhGVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+0emz0p2HvNv14BNijGU4e6uThWPiF7IiArBX2PLnTJcr3eHH/O3jZlaSZtS/+3YYXbyGxlKyPmlg2Ig5YZdEmFkTLtn6WU+n3MBbstVSlMPdruwz4gseWgcTcarBveyYD943WinGIyXTnxaJBtSl5igjnDJkD82b2eiE+32lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrUvMjj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrUvMjj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E749C4CED3;
	Thu, 23 Jan 2025 23:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737674453;
	bh=Dl0ICc71HGR9i7d5TCOBBwkilSh45O7AoQ8vo4PhGVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrUvMjj/rVEYikmp9dJzr3wtRdjVL62rSeGRSEbKzkrBBp7/gyl3KqRiqiIEaDwGj
	 1M2FOYCvPrm4Un/te5m9uAKkpinYIKBG6dy78h8Ra6tZXzooiZXudRqPe95sGytyik
	 pqu4jCtTn7lmNmXrqu0aMsTxa78DeG/tDXHULmmWF5S+eZQFMjLrfHLXR4MrbaYNqp
	 N043FNNMPaybXI9gMLWgQ1ZPXmeuewecKORp4EaydmOodeqOEUOqntY1+tJwB6Pfk3
	 25cPz1nT29Bx6FZgMM/70bNzlOXzo68iscEhjhRJ9YhfTlcj1EbgqEt4QXXB2RHH3L
	 IKfLG7+2oo9fA==
Date: Thu, 23 Jan 2025 15:20:51 -0800
From: Kees Cook <kees@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 2/2] LoadPin: Make sysctl table const
Message-ID: <202501231520.EDE65CDD70@keescook>
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
 <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>

On Thu, Jan 23, 2025 at 04:33:35PM -0300, Ricardo B. Marliere wrote:
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows for struct ctl_table to be
> in read-only memory. Move loadpin_sysctl_table to be declared at build
> time, instead of having to be dynamically allocated at boot time.
> 
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
