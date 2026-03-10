Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CA3A7599
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147714; cv=pass; b=C8XE8X9XI5tDZMQ70Qkm150V4muIS2Kd5vmI21OLaYFdzThAkbfp4TbG2kq6BKe9caha14DRec4URpM/Yva4AOqtIyB65JvmfMKfSKdn5uZpEb6f7RP8F33fi7wbZ3zchuhIO5J67XXJka4OkpW5yZ306P82PkQhD9/gz8I/wV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147714; c=relaxed/simple;
	bh=80A4i9KCVIM2d8s6pDs7ug1BHJ5YHRI8JuOyIT6WgPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMB1vP5Eq6QzYG3bn4fesLUeLoTTAc46q9oNxzFy+qDXse2dZjCwWfqw8FpH08lTdtVh/So9S5tBuWy3mtgciAsJoJdOBdPY+6W4vK4DyEBoyVbaEkbOt13sguxQCTtDEArHw1OB4+rXPwJK75mdMnA9eOoJ39IEUdgE+KJmVC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsB+25vM; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsB+25vM"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a1443780c4so3134572e87.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 06:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773147710; cv=none;
        d=google.com; s=arc-20240605;
        b=GelK5hxzFqPjhozS26EakMAnXsqLOVzSNl7PHW6EWTOTHv5+P2O3mWDBF7a/IFT5ip
         OvenXGbtaN4efODbHB9eBEQnltaNZh3NwV7JziqxW9Y/Llz636Kf15kjzVntDsu66hzZ
         +gteEum9eI6m+9+0PERhk33xyYek0kz1umRekBgWgPaFGeHm25ODzKaG7HI46YUfmyik
         kZh0oinJP4jIKnDJzfEXEZOdsJuF376tj1ui/Pd6vCCKVRHKWnMHhBaVTkpvLSFmjJnC
         +51ngf5HNecpnMtGpNY7SpfnwroEGoUut1+oWY6sIvxD2EHz2QPTSdpE9R1qwLdalP1U
         zqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HmXy9GuoY1W34b++DDgqfMop+biZa4H7WtjxNpBzCHc=;
        fh=FH7xkC3g6rq+ba4geAKTVGdYLsc189ksqncYtoNBuPU=;
        b=O3tiVQtwf7QYELQFH2WCFKGjukIBM7W7FgrSkQAfOYbt6MFL7voRymOjfc+9g2rKc6
         8QW01GozkVZpv2MbdaQ0AB0c/KETUeoQNZU0LE5AGjZnYrg+DovHUyLDzLKZLLtxl+u9
         WWJzgrM2H/kGZ2GsYLqjtHvfSIo6HSq96qRxf3UPhSUI5qzRN5wP6IORzIWar6yHkuFv
         gKEZ16UBCd4w8HL4HlwuWvfNUYsF+jazdaKI+nsFs/ZVormuRPZ5UJUwPrniDe4addGL
         P/5fwLlRH1xj99f1ViNhUPf042TYDXInRbm/ZVOJAX9UUGPUlIOTnkJuS4FfrqiMXV3F
         fnGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773147710; x=1773752510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmXy9GuoY1W34b++DDgqfMop+biZa4H7WtjxNpBzCHc=;
        b=JsB+25vMbEuHjklEfrkhYeJI+Jj36/q1XG+wdh958FhWGtyxMFPPbajXy2F2tQEhWE
         LLtCG5auEInB/I2wqsSSfcSfoXsHAsc/THg400rlBXcfrlfqj6WLANZWK9NGZZiwX0Qf
         YIz94CMUJiC+8zcu8Jk4SWS+sOF6WO014qGsgMvVl5gLDMGpIRfHr4NDrXxX9HX4LLZo
         huJRZXXU+Hl2sx5+evqsvXVGYFxULXozKUerR0gmTLKuP8NqaRfHIMPLwn4jAyhdKN2I
         /gqK1f6wW3ZoCOE4q1parxyPTDynJqVKNQAVgYpStf0E1iZriPO+DbrVLv4OPVODHIzn
         yYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147710; x=1773752510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HmXy9GuoY1W34b++DDgqfMop+biZa4H7WtjxNpBzCHc=;
        b=Fc7WnSIwR99PzSi5hpYArWj/V916Z0GGK6EZUWmqfg/q3UwBaC6rMuwpKcPV3LK0h0
         ZMlo/ZgEZEk0dCSUC6POdb4N4XEktXKZyZabROa8OU6YUCT3KfGKxDEjcF262aT5M0Nm
         7x/ba817//DNFbiTBE8aPSy2GqiEDrycJ1QtTgd0ZXOAosIaKFtoyQBSSQ9+sKzgEbxR
         pId+zPb/bYAc55euij2wwGxJNY5CaV5z7WF8CWK47anVDA954jGdBxPNN2YXv5u3ZDQG
         qqvAa8b0tDO17QYESGP8wokbLZCa73mLDfnr2dSnTDTIkdRNhIa3Vgoxqw8EA4C6AYYN
         QViA==
X-Forwarded-Encrypted: i=1; AJvYcCXmzNUYgilcGc4n06KLL2KczQRIlGK9QkKgaUBk9+FZ6NcfHbTvPeOxgBF6/FAA1GGxd8y67pNzE993eN/OB/ML1o5k42o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAKy1NHVPURJMYCdmIl/ZYIdQ2x4BJppxGZPLu4SVJXwDk2Q8
	vZNM03WnvxPmdvQvT6PYtoRQqsCzU12opBzMTepud+ijRmSM+T2Jz3lkhIa0WPbBIPRCCROWmn4
	uwk+ie8tGqfiQxt7k1qKWgO+aPYaHc2I=
X-Gm-Gg: ATEYQzyIL9KLm30n4k7jJkyuYEoW7hahN6zk5CcgjHDEnz3sGisqUzzUM+HokLv3lu0
	Ho1lQWQpAPwYV5zu7wbPOfHmEHB4wV3bWX8Idwi/sgbYVPsGuCdUZqP+F1l5CES9/UxH/+yMHst
	RlSCXrxpQWY9nfihgS5L0/zOIa9IkXOvHxknRzAOSotRUWVnAVnuxHW6eB8wE5HwOWeV8zVdg2e
	30KFIQhV4GUp0O4+BeP/xivEPoKRH6bYzjusvTBIissYPFG3f+3nsrQ8r5qRca509m1o0Km5OcE
	qtkQRWSl57/F2ovcng4=
X-Received: by 2002:a05:6512:67db:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a14e48a613mr874536e87.18.1773147708096; Tue, 10 Mar 2026
 06:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-iino-u64-v1-0-18422a053b04@kernel.org> <20260310-iino-u64-v1-1-18422a053b04@kernel.org>
In-Reply-To: <20260310-iino-u64-v1-1-18422a053b04@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 10 Mar 2026 22:01:31 +0900
X-Gm-Features: AaiRm53VuLCINpkeyLwgGa3qyn5MXOBgR8oSJIecEGpm5hN3ZsL6dTvldvEDd5w
Message-ID: <CAKFNMokA0NrTT-iXzhoN0XVJtWQF4+SytZNefseEsGi++LxseA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:44=E2=80=AFPM Jeff Layton wrote:
>
> With the change to make inode->i_ino a u64, the build started failing on
> 32-bit ARM with:
>
>     ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!
>
> Fix this by using the 64-bit division interfaces in
> nilfs_bmap_find_target_in_group().
>
> Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier convers=
ions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@i=
ntel.com/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thank you.  The conversion seems reasonable.

Ryusuke Konishi

> ---
>  fs/nilfs2/bmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..4ce9a93149a5af13bc215cc18=
77a757e2c6cf49b 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const struct =
nilfs_bmap *bmap)
>  {
>         struct inode *dat =3D nilfs_bmap_get_dat(bmap);
>         unsigned long entries_per_group =3D nilfs_palloc_entries_per_grou=
p(dat);
> -       unsigned long group =3D bmap->b_inode->i_ino / entries_per_group;
> +       unsigned long group;
> +       u32 rem;
> +
> +       group =3D div_u64(bmap->b_inode->i_ino, entries_per_group);
> +       div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &rem);
>
>         return group * entries_per_group +
> -               (bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
> -               (entries_per_group / NILFS_BMAP_GROUP_DIV);
> +              rem * (entries_per_group / NILFS_BMAP_GROUP_DIV);
>  }
>
>  static struct lock_class_key nilfs_bmap_dat_lock_key;
>
> --
> 2.53.0
>
