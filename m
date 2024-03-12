Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB4C154
	for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219952; cv=none; b=IzB+2aAW4nO4ayiymiTVgC0gydBkCGHsl31pNxESJYbMGKnU/Lnma8aU/1g8r00lHeRVPAj/SmgdCo42XRbFFq08zK0AX+tMwCxk9fFoAgTsZdCq8LNXhZodD7ep1euVHg9hWMd9h+sPJhYCNVY01o1OOxp26/OE/WA/0qOi53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219952; c=relaxed/simple;
	bh=ahmjDRASmT1GsVFsQp2K4Le3kshZFxbSMcLk1E4qeCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEjHxf/MsR6g/YBsW3UHyHXaHvT/DflSBT5xlGbpgKpaSyCgx0aMGwWvhtUMEkVfJwlffXFC9DwF/h74au1RgBYHD2Zgdgf7SYtKoncUgeHQEZjd3Cq2KCzQWwomtqOCvOB6WjLCIlp6yJQ2ah1ipNziU/DFGe1bGbN0wVUjeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31BDIpYo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31BDIpYo"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so10207a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2024 22:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710219949; x=1710824749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JnBJB5c/+20ieV4/L8XiCWekgUdSTg+ChIwImz3g13c=;
        b=31BDIpYo7Yh5BPfaADr7sB12S2XdaNDKjyYfFMUwNXS6HK37z76yjlERKILJYbpyiQ
         d4ZxhjZrpvu1n2LGWN5MMIdjoJQlYaoCTjRN4q0T6QCLmv9jH4IPvsrLbBZJ/Ux+MHtx
         xQrav5maPI1A8ZCc5DynIJQS3Ypa/1+VpppAcjoN5UYJ/KkScfLKSwGWmIZcVFR2u8Dj
         Mdcu8mTdJ/2iRc+PUKxBgrMp7GI6VmBRfNbAH7+/GTlFj5TdowSJvV6CX/4AUJ+qUy1M
         g2H4r5amPcP1bj0n3NSIybpV+BBkX0SuT7V/hhxqxuJFQViQukE6rnbSUnjXUq5O70VA
         t9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710219949; x=1710824749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnBJB5c/+20ieV4/L8XiCWekgUdSTg+ChIwImz3g13c=;
        b=gj3wy5YNLifjB33RkrQBUhHJK6KwVVF/R5110s5WNev0hA3vJmRACelV5gNosoNeo8
         PytkN+KY6NMHEFOurkeLJfzI/31SsviifEzgmSpET/m6xb113sfypMqIJh5DvTqnFwSI
         QKasiSwrdmflvra+rE1wo+SkP7b9E3rCpFdXI1U58SBiKckZgX3cciPHeOAnFi/VWgz2
         Ap8CzEdA219trA9P6kJZIeoIZSH2SPpgD+RBGlAx8dfvQVA3abZyxIcKp//OnnJZqFKH
         9iU2gwyzIxdwiFj+u9/3wM1KEWVetvvtEdokuR9mhwX0WZEKgr8ZNTgRzIgezAlx7Z/s
         dJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3IeVZnOUVWs+yR7SRX84Cyd2hFdjMryBSuLzYCXlI24PQ7F4ySCfMrtmc4/HhPucWIEs7Iza6fIAAms/YRjiPAl1AJ/Q3vh+VoRS4N65tKhgQjgBh
X-Gm-Message-State: AOJu0Yw/5d5MfPjx5k9rbgF9/ILdRNIaKL4aC2xQgi8EZkELiAuJv6E6
	CFEJMCQwY64NLE5DzOjuZp4XI7V6dv20Vnff38QzY3UQpOUZhyd+7EW+SvIiTZibTW67lWqi8sr
	1BI7sYvYODxG3o+CM9Ztcbl5YrK+nwze6aC0m
X-Google-Smtp-Source: AGHT+IGRElbVD0Y6B6qmm2ZO+w6/salLKCB0NWwCiMf7AWYvsPywYoNQYDET87p1th+nlq1sLCVVSvrfXFG40uKoRWg=
X-Received: by 2002:aa7:c2d9:0:b0:568:5e6c:a3c4 with SMTP id
 m25-20020aa7c2d9000000b005685e6ca3c4mr110847edp.0.1710219948786; Mon, 11 Mar
 2024 22:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-5-mic@digikod.net>
In-Reply-To: <20240301194037.532117-5-mic@digikod.net>
From: David Gow <davidgow@google.com>
Date: Tue, 12 Mar 2024 13:05:37 +0800
Message-ID: <CABVgOSnzaO7EUdSW_xTZd22oc-q_yT9uVoSwTm2jn5pw5pP8Eg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kunit: Handle test faults
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, Kees Cook <keescook@chromium.org>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
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
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000907fa806136f9cb8"

--000000000000907fa806136f9cb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 at 03:40, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> Previously, when a kernel test thread crashed (e.g. NULL pointer
> dereference, general protection fault), the KUnit test hanged for 30
> seconds and exited with a timeout error.
>
> Fix this issue by waiting on task_struct->vfork_done instead of the
> custom kunit_try_catch.try_completion, and track the execution state by
> initially setting try_result with -EFAULT and only setting it to 0 if
> the test passed.
>
> Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> instead of calling kthread_complete_and_exit().  Because thread's exit
> code is never checked, always set it to 0 to make it clear.
>
> Fix the -EINTR error message, which couldn't be reached until now.
>
> This is tested with a following patch.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-5-mic@digikod.net
> ---

This works fine here, and looks good.

The use of task_struct->vfork_done is a bit confusing, as there's no
documentation (that I could find) about what vfork_done means for
kthreads. From the code, it looks to just be a copy of
kthread->exited, which is much more obvious a name.

Would it make sense to either (a) replace this with a call to
to_kthread(), and kthread->exited, or (b) add a comment explaining
what vfork_done means here. kthread_stop() itself is using
to_kthread() and kthread->exited -- even though task_struct is also
there -- so I'd feel a bit more comfortable with that option.

Otherwise,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  include/kunit/try-catch.h |  3 ---
>  lib/kunit/try-catch.c     | 14 +++++++-------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
> index c507dd43119d..7c966a1adbd3 100644
> --- a/include/kunit/try-catch.h
> +++ b/include/kunit/try-catch.h
> @@ -14,13 +14,11 @@
>
>  typedef void (*kunit_try_catch_func_t)(void *);
>
> -struct completion;
>  struct kunit;
>
>  /**
>   * struct kunit_try_catch - provides a generic way to run code which mig=
ht fail.
>   * @test: The test case that is currently being executed.
> - * @try_completion: Completion that the control thread waits on while te=
st runs.
>   * @try_result: Contains any errno obtained while running test case.
>   * @try: The function, the test case, to attempt to run.
>   * @catch: The function called if @try bails out.
> @@ -46,7 +44,6 @@ struct kunit;
>  struct kunit_try_catch {
>         /* private: internal use only. */
>         struct kunit *test;
> -       struct completion *try_completion;
>         int try_result;
>         kunit_try_catch_func_t try;
>         kunit_try_catch_func_t catch;
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index cab8b24b5d5a..c6ee4db0b3bd 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -18,7 +18,7 @@
>  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
>  {
>         try_catch->try_result =3D -EFAULT;
> -       kthread_complete_and_exit(try_catch->try_completion, -EFAULT);
> +       kthread_exit(0);
>  }
>  EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
>
> @@ -26,9 +26,12 @@ static int kunit_generic_run_threadfn_adapter(void *da=
ta)
>  {
>         struct kunit_try_catch *try_catch =3D data;
>
> +       try_catch->try_result =3D -EINTR;
>         try_catch->try(try_catch->context);
> +       if (try_catch->try_result =3D=3D -EINTR)
> +               try_catch->try_result =3D 0;
>
> -       kthread_complete_and_exit(try_catch->try_completion, 0);
> +       return 0;
>  }
>
>  static unsigned long kunit_test_timeout(void)
> @@ -58,13 +61,11 @@ static unsigned long kunit_test_timeout(void)
>
>  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *contex=
t)
>  {
> -       DECLARE_COMPLETION_ONSTACK(try_completion);
>         struct kunit *test =3D try_catch->test;
>         struct task_struct *task_struct;
>         int exit_code, time_remaining;
>
>         try_catch->context =3D context;
> -       try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
>         task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
>                                      try_catch, "kunit_try_catch_thread")=
;
> @@ -75,8 +76,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         }
>         get_task_struct(task_struct);
>         wake_up_process(task_struct);
> -
> -       time_remaining =3D wait_for_completion_timeout(&try_completion,
> +       time_remaining =3D wait_for_completion_timeout(task_struct->vfork=
_done,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
>                 try_catch->try_result =3D -ETIMEDOUT;
> @@ -92,7 +92,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         if (exit_code =3D=3D -EFAULT)
>                 try_catch->try_result =3D 0;
>         else if (exit_code =3D=3D -EINTR)
> -               kunit_err(test, "wake_up_process() was never called\n");
> +               kunit_err(test, "try faulted\n");
>         else if (exit_code =3D=3D -ETIMEDOUT)
>                 kunit_err(test, "try timed out\n");
>         else if (exit_code)
> --
> 2.44.0
>

--000000000000907fa806136f9cb8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIJfI7FFT1hk5kEePurOKEQopyEMAeRpCSPqaHED/OhmeMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMjA1MDU0OVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA7KrbG
1GQCdjphAh9ZYbU3FD6k+ZQb4U/vtZduRXTlviunKYY7u767bxtj3dSk1V8GNy/r3MMMqpLOoZK4
HvkmStF3b3Reh+b0qUpRoUcXtSmgmbbyNsxWIk74PQhyOshB152wbRjRGkr1K1u0J0Cfm9HXBjQV
Il58pJqeb71jRcZgF7UUhiffPnfjyD160gpe0vEsh6mPV+WncXB85rBPYxWeZrI61iD5UdIVPdAW
pUvKKpvQIjTugbeHa7TM3a+G0YTRAIw4jp8X+FVDlQkXObD5qyWvhnyTs/G9Mp9GERVLI+Foclle
gUIAJJtr29mJC48jpgKxFE2OFyskpD0g
--000000000000907fa806136f9cb8--
