Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095851EEE6
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319290; cv=none; b=beEEll6xS0wMdHxbVhAlVVMvnGaOVJiFpF19Uy+O2T8OYL6PySrs7ot2ZG8n/n96xcJoDsjNihTCCHO3iik1s4meH7DLraExlSGEuUIvAYWccTMR8BxaTmI6VtIwU23TY7P6P2Qxb9Oea5FLVXbx1Vtg3crfmZcgC3IBv+f1uwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319290; c=relaxed/simple;
	bh=dTQtBMDvmSV2r4k7FWElep648Zj5VqCzYNr5DQhz+P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYnDbbTYYED5KAjqtM3U243RTdQ3WgqwvNHw2aRm4ZVlkytDqnyKSaFu9i/pFx5h8w5BMaObKv6r/aYOE2V1xRblFW/xbObWO8P4x/54ASytaYY4mQewyhCEyxjSO7RZl7DBy82BjjR9XOo4nUmIH+qK+aP5HEIECE1bCHC0Gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owfy+vSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owfy+vSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56021F00A3E
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 02:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781319289;
	bh=dTQtBMDvmSV2r4k7FWElep648Zj5VqCzYNr5DQhz+P8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Owfy+vSCyVQUlgV04dfjl+8LW5A5WC3GJNASX92KGrdoOv8HiHWqbtc0aQe7dtpz9
	 u/ahTDFObSPsF7Gmv8TYekvLWOvWFW9Ze2H5OAW/7lkaq3Oq8sJE6qxWOGi0n6xPu8
	 2SdUUqgUdfhOVfzdpHnlqs30dUi5YL4t9Yl0zL4brrQxUa6ccEYgJ583+xHp/ed+eP
	 Rz6zjE5dnRxFzrz8CI1p/eqmcN9jwnyU8gltzQV5PcKdoMwgNrWPMMVmKo6t7syPl9
	 zuwBhHUm9clses25TtSJw+UJWAPl9TAGTkUKse1WnhmbXl2q1YhZZwzMf+Au45af3u
	 ic6iEw8AvaKsA==
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13721dfd471so1875846c88.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 19:54:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+TlamuekCp+eDit1PSG5KkIxRVHCOh5lYNDU9J/ADkLYF30+s/nyHZLC6w3V4hM+nbG/BGOWG/1WL8dlvU/WBroeNfM0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HfZkqaoQmK1JHlf5BjA/oiGEPpidWydCU59OuqoNAVDWllmD
	3bOHBHJrL0q367o8LikUi8uF27qEBGjYRtvaqO8E9A9wNM6k+qhjQt4dhvTmz1vz6wXfkjudFwf
	8+8+z5qbyNnGHFg32Dl3YukIE7d9yJtE=
X-Received: by 2002:a05:7022:3d0c:b0:138:4fc9:160d with SMTP id
 a92af1059eb24-138790227dbmr942234c88.35.1781319289300; Fri, 12 Jun 2026
 19:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781105672.git.zhuyan2015@qq.com> <tencent_DADDE291CA580302EB7BB40B83A552D6F006@qq.com>
In-Reply-To: <tencent_DADDE291CA580302EB7BB40B83A552D6F006@qq.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 12 Jun 2026 19:54:38 -0700
X-Gmail-Original-Message-ID: <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>
X-Gm-Features: AVVi8CftctKBny0jAU4ifk3qIkc0KbuixpNCAMW7ye9rflDa0lxZ53ouLeLjJ4U
Message-ID: <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>
Subject: Re: [PATCH 09/10] docs/zh_CN: add LSM/ipe Chinese translation
To: Yan Zhu <zhuyan2015@qq.com>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net, 
	dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com, 
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 8:59=E2=80=AFAM Yan Zhu <zhuyan2015@qq.com> wrote:
>
> Translate Documentation/admin-guide/LSM/ipe.rst into Chinese.
>
> Update the translation through commit d7ba853c0e47
> ("ipe: Update documentation for script enforcement")
>
> Assisted-by: Claude:deepseek-4-pro
> Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
> ---

Have you tried to refine the AI translation? IMO some are really bad transl=
ated.

Also how does the doc translation project work? I do notice there is
another IPE design doc translation,
https://docs.kernel.org/next/translations/zh_CN/security/ipe.html
which has a wrong "original link".

-Fan
