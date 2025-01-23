Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC961CEE9F;
	Thu, 23 Jan 2025 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674450; cv=none; b=M06th7YygXkllYM+HlfKNITmbb4KooXAqj0xhPizYRnWT6heqaSZIC550wyARn2yZpP9w1MccFRTUX3Qxiu3dY4ZLQU3JETCq89d9dZt3aMQXLDaz4RPVW+hQv6CCnY9gBVcURtd316ET89M/MCqRRcUGfRyjQY26EDvfHP6QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674450; c=relaxed/simple;
	bh=Isr23k8uhSFQE8/6eHj3Ql88oD/6/eiTDa7AbDZCqe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV7BnARkcQdT0u9tWv7anKgltqZfBLb7l3222/LymHM6KEAlbMr0ZmqhoqRN7/9ePPMsIbvGywjALdYx+B6kRaGAcjR8g1w4OLN7U69sWunmOtXUYCPCsF8ze8W8xpGnzTNXx8/FEa0foHsv/pdmty0NUi0/qF8xjzN6r1oyc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqYcGj10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqYcGj10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC96C4CED3;
	Thu, 23 Jan 2025 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737674449;
	bh=Isr23k8uhSFQE8/6eHj3Ql88oD/6/eiTDa7AbDZCqe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqYcGj109VvQURy8n3zTF2U80M28GCGd3B0txK83nger+VUfegGsZlA+MWGI1t4EB
	 MI2If7/3kSmCGfmXPY6WzdIDct2BLiJFnIQwU+v3RUv369xu8osasQ1wIyUg8JwXad
	 rYXQgXChuPEzKAJDKL4j1l3twTNwIDOcGARpB4n4j9gfe+mP1NfyRaQHc9SrIvLftb
	 xKxe0KragGLMo8cYq6sDdRlT6wnflrjRVyTUCQOouar0cPId8IvE1Oz3z26uPjatN1
	 H3nUo4Pk+FVqxIb4AjQAq1AvfDDZuDsEpnJIISTllmd6DYMGxO56kaSg6JjI8NlT7C
	 DgfGlz3pYOzsg==
Date: Thu, 23 Jan 2025 15:20:46 -0800
From: Kees Cook <kees@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 1/2] yama: Make sysctl table const
Message-ID: <202501231520.B8A527C4@keescook>
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
 <20250123-sysctl-kees-v1-1-533359e74d66@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-sysctl-kees-v1-1-533359e74d66@suse.com>

On Thu, Jan 23, 2025 at 04:33:34PM -0300, Ricardo B. Marliere wrote:
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows for struct ctl_table to be
> in read-only memory. Move yama_sysctl_table to be declared at build time,
> instead of having to be dynamically allocated at boot time.
> 
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
