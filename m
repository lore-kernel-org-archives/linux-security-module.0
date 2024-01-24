Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0447E593
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120998; cv=none; b=pN21O2T0JsKpx1ti8A53pW/NdwUXz13sPH/sSriKU4b4ue6cnyIb41+cHK1fymsfc9BlOaNaN+VDvIihQkSPbEzdXHK2R8iobXQzlafiEspSpw4O7b66TzYQCk3gzB1e0JRM+Kg5w16pNL4lt7rA5+vYDB7eJDttkHPv5da8wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120998; c=relaxed/simple;
	bh=SW6iKvLIfjtPb7161k0Be90L2EGbRQCt76qGG32t4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCGxmcg8cm3LIcIFYGZPWoPGOTi7AJdVwR5vT9fylLUpdod7hUcDL/kWHwtNKaMGKV5LlAdozL6Tp/herDYtj6C+3B2XO+80ETiWwQLk9DdxCVXBinhaWzGGR9OkWPgCXrwOg5SYVFJPhRwhcoY6/nuBi6CXWqZ5QOiJv+/WDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K4mXIT0y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K4mXIT0y"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5100cb238bcso2607989e87.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706120994; x=1706725794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0V0EohxWvuuUENl0m42DMDVa8sdRi34P5EyN97xnskE=;
        b=K4mXIT0yfeheSgC2LsLz2nHgNl6thRtk8zzRl3uwJozdi/FHPEAnDmrgy5q5NqAaMd
         mMED7fGAoTUmUbxgRZstGmrd8nk0duTbUE/qDyZK9uVGZHeCiiNr9t35GunDEfpIvrG3
         D1pJqA0VSY/ee7n5PDo+So61y+Hb7M05u/syo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120994; x=1706725794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V0EohxWvuuUENl0m42DMDVa8sdRi34P5EyN97xnskE=;
        b=nidrz03FedWYGby6HY6l3su7i+vr2R6cAgnlAzZZwaTq9Kf1OVhGyIpTnmnguQXB3Z
         ia6imZvpcMYPKaMUJzpKsY1PiQVg+gaA50QfKqSFN0GpPYYL75b7sts3YYYhd9jBsO+I
         wKHaHoUVOrL/y7/XNmgW2bxIDF/z0qdR1bNHGreocaf1BY6TgtsDEYBWfj7Nl8qArS1P
         0WhrTByxk0arXgGOWzVsqIw73nU5E5G+F9iNA0N4Hl6ii2WyXHVAUbXgSuUBmQiWLWj6
         z27Wvxf9mbW8wq4klaXl5QNI+d/fSeSHXPtk003ohMHWKQTvUZ+GY0QNYjQqT7edUcDO
         m4Zw==
X-Gm-Message-State: AOJu0YySZybLR/tkjak2kKsmDecB3Y4dogSZ8hmrTOAZht79oUdq2jyC
	5rAgcdSO10SX02QJiBRg2NXgA3YtjJHmONR0EDJRZOhz/qxiiUU2RYLFYBODydbuQrsXc7+0dy5
	CXUTNeQ==
X-Google-Smtp-Source: AGHT+IEsKusDTbfCTLIcruKEjFJq6gvKkUEm1iNtXHcEhyiVkZYyfhUnUaOQsXBCCsyx79xTXuSypA==
X-Received: by 2002:ac2:4a8b:0:b0:50f:1ac5:758c with SMTP id l11-20020ac24a8b000000b0050f1ac5758cmr3471414lfp.17.1706120994445;
        Wed, 24 Jan 2024 10:29:54 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id be42-20020a056512252a00b0050e754c84f9sm2653598lfb.67.2024.01.24.10.29.53
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:29:53 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so78167861fa.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 10:29:53 -0800 (PST)
X-Received: by 2002:a2e:be05:0:b0:2cf:784:d3c4 with SMTP id
 z5-20020a2ebe05000000b002cf0784d3c4mr1264354ljq.35.1706120992964; Wed, 24 Jan
 2024 10:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
In-Reply-To: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 10:29:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgx71FcBsPF_sWoGAHyL6ohG8NRtCdPEqOt1jtSpiJN5A@mail.gmail.com>
Message-ID: <CAHk-=wgx71FcBsPF_sWoGAHyL6ohG8NRtCdPEqOt1jtSpiJN5A@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 10:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> UNTESTED

.. and just to check who is awake, I used 'file->f_flags &
__FMODE_EXEC' in tomoyo when 'file' doesn't exist as a variable.

It should be 'f->f_flags & __FMODE_EXEC'.

That way it at least compiles.

              Linus
