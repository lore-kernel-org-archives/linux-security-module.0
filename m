Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cQ6Zq6L5"
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574D51BE8
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 09:55:28 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-dae7cc31151so2382646276.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 09:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702058127; x=1702662927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCroPR9ZSP2l8V1Q6/VGHsN/VoOs8Z300HzuyHm+39A=;
        b=cQ6Zq6L5gSnO1NLAqIyLI6mWxq33kqfysEs7JIDaaAEQI0o0r0j677TC0fFCwTMedh
         Pi/85w9K+uwLhjyKQ8+AESs4Fw2xDSkkkirLmB7Dw3jntBhyJiuhMp2cw4LOQSon0ttE
         PnrFC38DXVfCJ1ikcQkznGisfcGJzzNMHkOKSg6lpkj2oWCA3yMqAfS50HqhjecE2OGL
         T4tdIeZyyHCUormqPMZyW9H8O6RbRJSC0iMQF1skUN7oZFH/o3GLPpf3UK9c/ZpCfUra
         7rYek0OmY3gZ/gxxpShSj8nzN9uQbb6qckzORI9bqeCox6NsqjGLh9nB8yMq1QPV+oja
         xTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058127; x=1702662927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCroPR9ZSP2l8V1Q6/VGHsN/VoOs8Z300HzuyHm+39A=;
        b=cVDz1jvtiltvL3z3B9PMRG5Cv8YcHLEEnyTcRDa9USg8334XTz6GK/yJvoYAog1L4t
         k2A8oZ/QDtP6CrxvCs746tFQhMzjiND1D2w/DlmUAxodu0hxn8EkTJR+LUEuLnlZo+61
         Qx1JFlKCdWfNwwe1XvZ4oIe+4P1GlvIBJLK8sZPaTDgui64gjBUWdsFgfAnLSbDcTTwM
         tC42g/pzqqOHIUBDcpLIM0gZekWbMxvXvGgIDFkj9QLE0ANIbOx6gvcKdZ81uy2VZKfc
         6sYOoDy5qp5yoC0iRk/Qj62SW5Wm5yolOMu1IPmX7H9YA1OUJ6WOxasHa5T2hTN/e3W7
         Vwew==
X-Gm-Message-State: AOJu0YxLhZbY/aLMmGVNocFR/1LK7n64HwgVfwrHFmzrU9dDSv19SiSB
	2fphtzipXHyOpwJYd0QCQC8qB6WXkitR0nvKA/JG
X-Google-Smtp-Source: AGHT+IEzwsy0AZ74EL4/wTJn0JdgikevOqFD/o+di1wOmB2RJdQnLNT09F7tlAh0y6LFyfimUSDSndbsxLSTFXKTKHE=
X-Received: by 2002:a25:ae4f:0:b0:db7:dacf:6fdf with SMTP id
 g15-20020a25ae4f000000b00db7dacf6fdfmr390213ybe.103.1702058127436; Fri, 08
 Dec 2023 09:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook> <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
In-Reply-To: <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 12:55:16 -0500
Message-ID: <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Dec 8, 2023 at 12:36=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> > On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> > > [...]
> > > ---
> > >  security/Kconfig | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> >
> > Did something go missing from this patch? I don't see anything dependin=
g
> > on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?=
)

I guess while I'm at it, and for the sake of the mailing list, it is
worth mentioning that I voiced my dislike of the
CONFIG_SECURITY_HOOK_LIKELY Kconfig option earlier this year yet it
continues to appear in the patchset.  It's hard to give something
priority when I do provide some feedback and it is apparently ignored.

> > Regardless, Paul, please take patches 1-4, they bring us measurable
> > speed-ups across the board.
>
> As I mentioned when you were poking me off-list, this is in my review
> queue and I will get to it when it reaches the top.  I can promise you
> that continued nudging doesn't move the patchset further up in the
> queue, it actually has the opposite effect.

--=20
paul-moore.com
