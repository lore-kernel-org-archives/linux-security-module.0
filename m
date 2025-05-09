Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9021B9F5;
	Fri,  9 May 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755744; cv=none; b=KJB3LR/h+RAgaEfnK49ozKUtDOXTPEMIH5kX/ghF5fhiUX6E9PWWbpPLLnoNPy4DKgkY484mA7Y7U2CBsvJlhztwKLSxNdbK8J3t8VkYBz1rb3l/M/olWCDp/tRvRMI9tg8dMSxT2gUVIdMO2uawGpyBNbQ+iwTG15Lv92/PHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755744; c=relaxed/simple;
	bh=3qohBh1S70X52H8qD/9yNzSicrJlHsYElyiU+29K0Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihuCey0bTHj/rNYnHId2m7Fl2pbdDDdpz2Z4CZTZkvSFaxDpN2re/yF7NrbePrWkjinPNLS7IlpsbShS5GxiaseS6P3+upVScR/1Pi973z59w3G4u2lMGABtzwUYkfSdiHtmpW1xIfTHQcMJQY1Hzo/GFqRAbPZiVZLcTx4voMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK5vn30I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK5vn30I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E450EC4AF09;
	Fri,  9 May 2025 01:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755743;
	bh=3qohBh1S70X52H8qD/9yNzSicrJlHsYElyiU+29K0Oo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bK5vn30I2stVBDzBgiBEhM45wdm4/qRlEaEy/yK2YYewnsrPIDBv9Sch/NyoySM9H
	 qRUlVKLshXrnHC9ywvZRQWovpvD23R7hNII5pzqA668zXdNl/GJLxxPpJdlbdamX+0
	 sm2lU9wo1ir5za3JQVkFVIfJmRKgKfRolXOJpW31PUORk3MWfTzvRCY40KemYB9Pts
	 SJgruzFCIkcPDne2/uEJbcm2PbCrEkGL9KfggZw8P02MBqKerenXvMnTyYxGSwt5bc
	 GzaUZYaAqEP09yzxVWk7U9d72R/tSqSnvRZVkIqK87rfO+p/N2fbOUCTS0KU6+C+mF
	 XjP2y/dKmsvWQ==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70842dc27easo17546407b3.1;
        Thu, 08 May 2025 18:55:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0k+C1zCyLUmiPdzKzUN9/5CNBCQvG5f4YYkjZBuSeuFYdoYscM4MWtnt33Z4AKgke6chZntiYtag01rivKBtKzdYxrkvQ@vger.kernel.org, AJvYcCVsdM9jAtKpsjE5Vh5ZWX+OYjv4JCEO55MpJzzM2FWwYzzcRNdMbLv4SAC9OzENflUPATZYIaFbZboqsUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbVlryZckbfyO5Rm9yVjY5qcfSlEtuCqYI0DJY68R0vYdY86F
	9LJJ3vM+vxHuRoidgje9rY1b4o5gGftE4OVd2mKdbDYx0Q/qRBVlyr/pMSGiTHtjkqkEHzfD6Rg
	bRan39pnlH3zFGbYr5EbNnn1Ggmk=
X-Google-Smtp-Source: AGHT+IGVGt4iqiQyouWQeBPZfxbapPvKYf1XqWHGcAs24T4M75F72yjaaYFWouPIq5NhpN6YJlVPUmsxjLK04YRj4A8=
X-Received: by 2002:a05:690c:3342:b0:708:15dd:712 with SMTP id
 00721157ae682-70a3fb75b05mr26166357b3.32.1746755743283; Thu, 08 May 2025
 18:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
In-Reply-To: <20250508140438.648533-2-alexjlzheng@tencent.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 8 May 2025 18:55:30 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGK3JH7amgskrjMyUz1KZeVtAO_4bA_8iuBYvykgHRsRQ@mail.gmail.com>
X-Gm-Features: AX0GCFu6-abrfrlYteejuoljgud6oiquVwzkfonZBgR_wQujxQACtarehE1Y8mM
Message-ID: <CAKtyLkGK3JH7amgskrjMyUz1KZeVtAO_4bA_8iuBYvykgHRsRQ@mail.gmail.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in securityfs_remove()
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, viro@zeniv.linux.org.uk, 
	serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 7:11=E2=80=AFAM <alexjlzheng@gmail.com> wrote:
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> Consider the following execution flow:
>
>   Thread 0: securityfs_create_dir("A")
>   Thread 1: cd /sys/kernel/security/A           <- we hold 'A'
>   Thread 0: securityfs_remove(dentry)           <- 'A' don't go away
>   Thread 0: securityfs_create_dir("A")          <- Failed: File exists!
>
> Although the LSM module will not be dynamically added or deleted after
> the kernel is started, it may dynamically add or delete pseudo files
> for status export or function configuration in userspace according to
> different status, which we are not prohibited from doing so.
>
> In addition, securityfs_recursive_remove() avoids this problem by calling
> __d_drop() directly. As a non-recursive version, it is somewhat strange
> that securityfs_remove() does not clean up the deleted dentry.
>
> Fix this by adding d_delete() in securityfs_remove().
>
> Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
> changelog:
> v3: Modify the commit message to avoid readers mistakenly thinking that t=
he LSM is being dynamically loaded
> v2: https://lore.kernel.org/all/20250507111204.2585739-1-alexjlzheng@tenc=
ent.com/
> v1: https://lore.kernel.org/all/20250425092548.6828-1-alexjlzheng@tencent=
.com/
> ---
>  security/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..d99baf26350a 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
>                         simple_rmdir(dir, dentry);
>                 else
>                         simple_unlink(dir, dentry);
> +               d_delete(dentry);
>                 dput(dentry);
>         }
>         inode_unlock(dir);
> --
> 2.49.0
>
>

Since this could impact efi_secret_unlink(), I would suggest adding linux-e=
fi.

-Fan
