Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781D439333
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524635; cv=none; b=q+JyxVb0Z+pTtWKFfiohruxoi+vmmsec/s8fYymHCVFkJHxwO5CVahQOvHse0DFLcYDabMkkyP6Ks1PyctEUpVtxdTksMkmLM7M0u4QhMTqCq9vdyoc309kR4mJ6++VFksrQI6Nkv3Lri5J8ooiFrhTiBl940P6MoCBQnQ3hJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524635; c=relaxed/simple;
	bh=+K0GWwP++miXZhqrHGIysTUTZCK2YZLuGMHTFRSqh6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ulVwWAKEOwf1qYXIiBZ/dR5fU48HN7MA2kJUSaDca5siofZE3p6WTP38mXbXPy9B2azGtv7Lu6FPaNAZbU56J1aSS03WtZsxqNZ4KypiwUX+DOqBkH9drSkq4Je2uqjIkn9zGv7H7n779SfkUz/v15Wr++afP8Tu/EDr+AXsIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSARACWj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSARACWj"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-492488f8583so15622705e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783524632; x=1784129432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7/MSE8rhgIOyORzOhiK3whDWmmMC3npMcCh0YLsq7o8=;
        b=pSARACWj5iTuDVtxmaqK1m0jD+Tn7auRGpOLmEnpNmOq4WXSx5x8EXn5fzEA2Xbsx8
         9kAvSNvuKCJQ8wr0ViX05qPZy4fgSY4TkrZ/n+lG3YW8uFAeYS2V1gjT7UTPz0olzNuL
         EzYSKNIKtKqaqRCTf2dgRzCnNYx4ckJqzNbCdGqdx9y1sQi44KC0dYuYtNEX586lBFFF
         LwkeFSotW07gxivuvC/JrWRuB96hTX/Sxt/u78y6VKWPeg8AUCR6dtP07igZjT8PaxH0
         lyUQ8PZweFXyKqWcfAEESX001dyx3p77jM7KU1s+xB9BTRIC1BCwJcZ2KaZy1IL/pVWE
         waGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524632; x=1784129432;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/MSE8rhgIOyORzOhiK3whDWmmMC3npMcCh0YLsq7o8=;
        b=Zm83YKZvmsVrYE0IGwfWYHA2hw+qN8aAdJjm06N/36RZYAg+HSpKDSL6F3HQT7iu3r
         y+mnh1RsX297648a4/qn6xrAr3N4qiuhwUwsBBHTKoeEi/50bMt1k4FiPA1PdLO6C/5A
         XYOC/iExcYkv5NUZLmuUwGDSGHPlxD+UoaTnI5gXpGsUDcg53z6H48VJorlRgYvpqEXW
         ZJFPlnMe9PMsIxComUqYatgbHCSIFzj7oFb4Cxkxee7FkHgIlFCHNsoW9VgsxuuJhAmv
         WicAB7ucKaQcgZbJ1CwwKYN3D2sWN8ZDAXXuzl64sSpUyJz5XZCpGPnOBj57LGmSaKGj
         nODA==
X-Gm-Message-State: AOJu0YylbUoHxAS24DUtyQ4l9Wq2uKA/lm06bq+suVuF14O449nFUyuO
	afBPjnsLWEJzf5i2VggcXYnT5LP+9QUFznBIZOG+Ddfuv7r6a6YX+vZk7jsVzRgbhcc/YkiWarV
	NVpzgTA==
X-Received: from wmik2.prod.google.com ([2002:a7b:c402:0:b0:493:bd67:3b3e])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:8445:20b0:493:cd3f:d097
 with SMTP id 5b1f17b1804b1-493e68a0f7bmr25524375e9.12.1783524632096; Wed, 08
 Jul 2026 08:30:32 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:30:28 +0200
In-Reply-To: <20260708110635.2083515-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708110635.2083515-1-mic@digikod.net>
Message-ID: <ak5s9LrUnrxlRjDQ@google.com>
Subject: Re: [PATCH v1] landlock: Update formatting
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	Bart Van Assche <bvanassche@acm.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 01:06:33PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Following commit 99df2a8eba34 ("clang-format: fix formatting of guard()
> and scoped_guard() statements"), update scoped_guard() formatting.
> Also, see the related fix [1].
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/r/20260708105713.2073335-1-mic@digikod.net =
[1]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/landlock/task.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 7ddf211f75c3..360d226d0f51 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -95,8 +95,7 @@ static int hook_ptrace_access_check(struct task_struct =
*const child,
>  	if (!parent_subject)
>  		return 0;
> =20
> -	scoped_guard(rcu)
> -	{
> +	scoped_guard(rcu) {
>  		const struct landlock_ruleset *const child_dom =3D
>  			landlock_get_task_domain(child);
>  		err =3D domain_ptrace(parent_subject->domain, child_dom);
> @@ -370,8 +369,7 @@ static int hook_task_kill(struct task_struct *const p=
,
>  	if (!subject)
>  		return 0;
> =20
> -	scoped_guard(rcu)
> -	{
> +	scoped_guard(rcu) {
>  		is_scoped =3D domain_is_scoped(subject->domain,
>  					     landlock_get_task_domain(p),
>  					     signal_scope.scope);
> @@ -422,8 +420,7 @@ static int hook_file_send_sigiotask(struct task_struc=
t *tsk,
>  	if (task_tgid(tsk) =3D=3D landlock_file(fown->file)->fown_tg)
>  		return 0;
> =20
> -	scoped_guard(rcu)
> -	{
> +	scoped_guard(rcu) {
>  		is_scoped =3D domain_is_scoped(subject->domain,
>  					     landlock_get_task_domain(tsk),
>  					     signal_scope.scope);
> --=20
> 2.54.0

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
