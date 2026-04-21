Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0ED386424
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805943; cv=pass; b=EQtDVXL/suW95nSaqC6aAUwxKBd/u7YfVXBg8WQIkMmeuRa4dW+bG5KEVi+bfF1LwCtIHlRBC8qFGN0CfvaymO9bdOlmo5zczYzroK+oMxqtWPsa7boa09qmF5ubskBY+HGwkipeu3hLNxtfQ3C5/qVKuw6DEIIYrD3QAlU3uTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805943; c=relaxed/simple;
	bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJagvdfdb00WqyIOPOyU3FoSu2CtFT5FnsUjfWrHds17HOoq1rQ0XPLIsyA+Vo5WzOloFhDjNicXrAoIsvtLmX7Gga0D2ukM+03lASQq7sfLyz0OkxPPNjSxhobHj524mz9AT8P8RMrSf73RyPWzfKW0HUA7hJBCiwgQ879JyZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkbVLyyw; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkbVLyyw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso26418315e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 14:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776805941; cv=none;
        d=google.com; s=arc-20240605;
        b=IkyVj+h7Y3+yHRPw93EPoYOM5x8Dd7HfN+2w29ikZXU3tJqBdoIlVOCJ/dg9ChIrhT
         JxVTZbVG+XmI2NQzD/qZbeaeXCQuU5otLbBKtIPBZp6v7fzxVJ6/xpsf12N0uXQj9/Wt
         0rJpD1kWPUCpFgF6+gOKRPrRQ9Ov0H8wV83klSSuhYqvKNxrf7p1G5b4mNyNZ3LTOP/V
         u3XwEgLcN9EC8ZRfevRRtm5YqPo+atux7SfC0RnRjKEcPqaF+zGa91cE0A5RWlgqLfaL
         ZWQ+AIdsLufdSeNa7GU9ffIckMSKp0gvmBULtZV1mJjXTJrLCNldmWCexBaiHXgR97Fz
         Hvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        fh=WHM30xWqOUSUy9EPslLFylHLjgpwLTXjq9V8KjqItko=;
        b=X/v67eoiYGjxOQc+MdJSG6pt+hArvCBoNaIyXjKXn+A17xNkez7M7g7Kt/cM5moEj5
         /mplkcRCgJqxW9MaZGM93+zSW+XA2zpfdB52hlbllYtncf9ocd/0vFlXZUSsFiTBO44B
         7W+dK79ce0Zp850J/vp5sYtUg/0Zq34ushhQwTBNXsB1Xem+PMBbNU1xchfIjcuw6uEz
         B5pjY8h+90l448ts7YFAX/bIZthwmwxPT+f6Mcw9ber1bLo41VpTypIrwdCJL7sOzzSm
         tyL9WvvXticERw5EAMsXsMjaVIus7xzUszq1SFtAER3QNrx7EXeqpuBjl2MxXGqna6K4
         3nHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776805941; x=1777410741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        b=RkbVLyywW2pe/i4FFjsAP7VdfebLNgXH7ZVzfuva3izAtjGOeyqkEo7o3tgUCwpr99
         Z+mOJ3zxtRqvZ8J5yknE+0x8tDTdBDH63F3lGsQdlKjHnDmR+IKw/jBCPSBS9ULrq8HK
         oDn1MtqO+ko0Ybh70mlMMWMAS6+rHkxF5Ax597BNkgWxUwwSwU54e/moXxQ2Eb0SlYrd
         zShZzFNWG6Fv+EmMiQSE6PshcaKiQrmfRext32vmNrsk5vYc/dBZL1yRtq74tjbhk/Sd
         +TIsYR8sqSoL6m4qRdJ2pPR5cp92OFhCJOFsC9+xBcArqFgaxLw6KUIBpgrvqRCQX77K
         hy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805941; x=1777410741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        b=KRMZu1+O1hCDpHxgCfNY7xlc8hkAGXtqGGuqzo2RCbzVV014+VV0lLSM7+/RqdW+NO
         uXeuDCUg8pxWiWLcjutz6hGWd2jdpBQ2b4pVoszaD3+SG7mU7Vc4BErb9Aa5YGikfjD0
         EqPh23gA5aeNNarVty9n60LCREvdmer/exA5knX2cO0fuHY2Xkp8MrfygnwxK0x49NJS
         ZUvNlwHpUv0rkdbpo2HPGvSnxCHNIRqng7a01XeZ5TCR8j/kShcTc1fW2sMe2thBo7Is
         FicafjiZ51ISddJxvVtKxlS47HwnJxJnqgvLSAQYmWBAjDBpBwxuzr8wuFubtT9TcG6o
         1I1g==
X-Forwarded-Encrypted: i=1; AFNElJ/6DtgdULnDcQNp2TrHfMdFp3kK2bwjBW1hIM482zt+yp360B3Z2WtU7+1vlm51VU3g0qRwQCpXo4XjFt3kp4NjFxU92RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIE4YyY2BofLP8tULybnDozffqyVCJ3ngj7hFcFPM4z5f6S5jr
	BArjuX9TmVeI5Jaf6zWfyucMR8Qw87hxildlv78df0V4zDP3l4e6asUopeUqfpgx6eyWWIbe7IK
	ZfR+hwm8fgfoYFfIKNnWRZZyszY0Dzdg=
X-Gm-Gg: AeBDietajVGkOpqpeNqIALeaW+8BoZ0C3OKVkrHvtRsvt6U0ZOBFuw1DAFhwczlTqe9
	S2Ax97i91JR1Gz82i0FGLSRv+ow0dJJcXwNJt6lagipA5YMyl01CPCy4SXvRQig6WkBid+eKqp3
	rMQ4Zf6AyOnr5kVQBmq08qC2CTGvdm49fWqCMMG+lQmW6e0qRJN78BfcuTxC4SXXuM/QPVg3cJz
	F7F60CzCIcToGhUTSIm/Uo9XBuBKsq2fHUuAY59nnQwNefqAy6Jb3Lgs7xbVENVxecFJVaFJ22Y
	jSWBQB0ha54NTisXy2YdFnoWZo/+q66zlmw6PpQiavlyJ2x3IXL95wN3AFlIVSDP7+SWuRpHyoN
	q8R0LLnqkN53FS87/yWgOadml0+9KvterCpdc
X-Received: by 2002:a05:600c:820d:b0:48a:569c:abab with SMTP id
 5b1f17b1804b1-48a569cadacmr54957095e9.14.1776805940737; Tue, 21 Apr 2026
 14:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3>
In-Reply-To: <aefnIw1Tx_2r5nkS@CMGLRV3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 14:12:09 -0700
X-Gm-Features: AQROBzB7FEGFcLIjJDbSZzRa8uWl-Vr2UW5AqVzs9gp0AZcsBB4lKtYQM5rh6eY
Message-ID: <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 2:07=E2=80=AFPM Frederick Lawler <fred@cloudflare.c=
om> wrote:
>
> Hi folks,
>
> I was accepted to speak a little bit about this patch series at Linux
> Security Summit this May [1]. I'm going to use this opportunity to
> re-iterate some of the motivation, what can be done today with BPF,
> drawbacks, and wrap up with discussion topics. I'd love to hear feedback
> from audit, BPF, and security folks to work towards a viable solution tha=
t
> addresses shortcomings to allow for better integration with BPF.

I don't think any bpf folks will be there.
Also giving a talk about it doesn't make it acceptable.
It's still Nack.
