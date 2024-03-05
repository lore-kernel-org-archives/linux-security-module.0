Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D512A16C
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672271; cv=none; b=k0zlmf8DwjfERsdFPWNitHTD+tFQAfT16sMfkBemH3i7BT6hKFxp9vzGZjSXgp1uvBQkMsnQ2+TGM/8j2REirzbNOgSQG/OVKCFXzAUuaSWeugdVRxdor+mYZUqN3VA3ltbUxFDNdx09BI42WSDtxtFbOTSCtr0JvdrXu+Wba3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672271; c=relaxed/simple;
	bh=4y2L0boXZTMV4TDb8hO8PgzieZmUzq9lbLSb3KvG8k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZWXbBRnbaQRFOGJw4mtkIKdUE74jFSoZ4Mgde2yV1WZV/w+J5F9Eer0/eF3naxOqKcN64z+BOseFcZY6c+09pJC/CSVIBgzV0Duus5Jkuy+5GR4eI8+ABvteMyNw1BuGdOdYyUpvwfdMGtb/epZhbeeCanarvmLx0+4K4w2xPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBWqCKDG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBWqCKDG"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ef8193ae6so81841cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2024 12:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672268; x=1710277068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=;
        b=VBWqCKDGDtqfSjtVb345vt3+W6a38qDDSmcNfrprRiqVm5KKVxFG1eaTAs9zIWM7nw
         XkfOxDepJJzr4XmZd2u0E14fT33iq5bTYaYJAj3YXIw3pmu04FxywWf4wDtLfOOe835A
         8kzpzXszReLLvUFCmeHlZGEqYf+80F8kAuEVgvBt84uIPsSTZBAmHO6jNpzDHrfodkz5
         c6WNZ/4ukxpBT5QAY192A537hKlu+uJfMgubl5uWcaSnP+OBxYno6lBa2Na//z/s/1se
         X7EpWXiF+JDkISNr909WYap/KO8NOmEeRwkBSjEq4MPYqu9SXDfRAV7It/+xUW8waKIf
         +byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672268; x=1710277068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=;
        b=aLPWnaYdrHTzf3nlaWKAledbW0KcJhfBDaP71wdCxvy3KdEW9O09OXpkrDVjL+j1VY
         CctcYYfeDU2XHzfGRYTSRdjAhlpG/lIn3LJL2KJ4GZ0DqwsLEswkLyqe/4NgA+HGabzU
         TByojdpUgm9RA+rxxlg6cmABpQZ6ELPyY1E6EkpVFxEPuEuMWFvIPyWqv1gO6CQ3MjA8
         4HCb8Kff39mTfrdJMdFeNuKpc3huvzK16exiubnnJc83cPttYpEBikCDKiQViwqr2Ng6
         lw0pPsdvbZynsgnfaAJ03RqmLszkt8R5mRzBIim/2ob9U+J4/bCLPJW6xN5QSfc1zJyg
         XrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Xp4B49hhgpUgiymog1I6PEgOH2WxbuuYuM2YyJpqKf7FP3Y4Qem2w42vkbHu21e/3fZwecckSOTNEJ1z03WUdZBPCPYTYEaACVOIMalflAHNayOm
X-Gm-Message-State: AOJu0Yw2omgRmPTKlJfYgf9zb2h3NvY0COQ+9o5JW8lxyI/TY9keHE6N
	SHvWmHZlC7SQlJun/PdxjjhaLOEo1Cn+xrE0LW8w+6zlh4LwqgPCGEsslxsQLj9wxGyOUpzVSQ3
	kTY9JhRQbemRXl6K0w8lATAyX0jjYCiPBk3VT
X-Google-Smtp-Source: AGHT+IHUUnMvT3jqlx4mYU0Zq3/oVljYM3tgXS+x8Lb6hAUG4wgFseZ7U1lT7XFjP+BusQQ9kBXfhI9r5cdZ6lf7hXM=
X-Received: by 2002:a05:622a:28c:b0:42e:6de9:cd13 with SMTP id
 z12-20020a05622a028c00b0042e6de9cd13mr258781qtw.3.1709672267992; Tue, 05 Mar
 2024 12:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-2-mic@digikod.net>
In-Reply-To: <20240301194037.532117-2-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:57:35 -0500
Message-ID: <CA+GJov4U+bXK3Q2cmXtsdnrNNiwuDmxsU4-ghVM_8M1vjyMVWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kunit: Handle thread creation error
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:40=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Previously, if a thread creation failed (e.g. -ENOMEM), the function was
> called (kunit_catch_run_case or kunit_catch_run_case_cleanup) without
> marking the test as failed.  Instead, fill try_result with the error
> code returned by kthread_run(), which will mark the test as failed and
> print "internal error occurred...".

Hello!

I have tested this and this fix looks good to me. Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-2-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index f7825991d576..a5cb2ef70a25 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -69,6 +69,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                                   try_catch,
>                                   "kunit_try_catch_thread");
>         if (IS_ERR(task_struct)) {
> +               try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> --
> 2.44.0
>
