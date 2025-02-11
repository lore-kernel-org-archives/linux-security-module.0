Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28A524F;
	Tue, 11 Feb 2025 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234241; cv=none; b=bNYaovbDMbsBZo1mCmO/N2S5oUtYDPofai3+j/CYSOu4VfY1mj7gurRuZXKarbPptgriOcK1uoBESYON0MQCRwYIhJiABd0dF0DsFZfHBeDZbQggqqRt3xVj8po4p2BqdCB8KTIvXqDf1vmbNJ52WhFcAfxjdIRmWUDCaih0gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234241; c=relaxed/simple;
	bh=GLt6m4//6evuO9TSKo2CUYJ3XYl/r9lCtLhgW1+PV8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzyJQU68+TMzwcNfAtkKRDWpZJE0w7LQBelH9vdjdB0yNEVr+cLzQX5U/kXfNwMfBOqQr22S9DA9AEGiQKcMxDWduIEVOwimuyefvTUt/n4oWUYQ5EcNMuVcHDr8chkpNLaQtvA49lLgBT3gScQo+49NxTV4vtF52DSZlPDbt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSKCYcv8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSKCYcv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2757C4CED1;
	Tue, 11 Feb 2025 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234240;
	bh=GLt6m4//6evuO9TSKo2CUYJ3XYl/r9lCtLhgW1+PV8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSKCYcv8vMXUWPUAsmtR03X0ABIaj2EBDdZSriZXFIfQEsu2nklZJHlnJIq28JiLb
	 cjywcf2f2Je5NW7LeCvEH/qW72SPPQAz6X68FOo15zzPVhzVak265p1M0Ob1SKBXlg
	 NDT8kc1w6YTxrKaQODI0y6/GDiNwILeoxET0a6AhhHGJ8JT9ZwWjf28KhJmlZ3bvyB
	 KFgJgIfBj06XPk4jozO+goFqgMmcOeYWImAToHwvh48buT0k31FsamKN0e2+nHgNjj
	 6uTLf7gwFD3nb1q3pISGM4rHD7Us9FLABO+LS+EzXbzKB4ZIjMx7ZQMfnkc1DfHk2K
	 C26AgPrfVN1gQ==
Date: Mon, 10 Feb 2025 16:37:20 -0800
From: Kees Cook <kees@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 1/2] yama: Make sysctl table const
Message-ID: <202502101636.C8D3F04@keescook>
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
> ---
>  security/yama/yama_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index e1a5e13ea269d4917fe2c78cb79f1d44881653c2..54bd5f535ac1fef9409ea96ad60825f565318daf 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -454,7 +454,7 @@ static int yama_dointvec_minmax(const struct ctl_table *table, int write,
>  
>  static int max_scope = YAMA_SCOPE_NO_ATTACH;
>  
> -static struct ctl_table yama_sysctl_table[] = {
> +static const struct ctl_table yama_sysctl_table[] = {

This was done via commit 1751f872cc97 ("treewide: const qualify
ctl_tables where applicable").

-- 
Kees Cook
