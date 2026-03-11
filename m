Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F02D0615
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211813; cv=pass; b=LVLgdzdmAycRfseex8QJEtJVyD6Xkt8scOO+40dCsns+tVmhZJQOBqVx9e/lrOhWMS/CKGNvzMggtbJpkkl51KnwUBwZL6W1O1NxbaWVM5KhvkJJj+tpy+rcM12+PVSMgarNFZhzRYuTJCzn2WPjVGD6dw9lzDniT3JQUWmyUVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211813; c=relaxed/simple;
	bh=ee0flKFWPAN6L2hqretB42IbZFab+WeaALmSOJk3jhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kr49A75ziX8+b3igJA1atyjsy5WTk07WIF61PWUHLMBwrQZDjqtFgrLuQAeJGOBUAyVNp3kHSTO7hps7BI59UYv+7dNIs6fVo4q0JcM0c9wJe2MogaPavVamX+TT2Rh/Pwu0KDNXy1Vp5eMvX7OyQ6d2wp9Muc+fa9XIuTIz/dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlV1vb6w; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlV1vb6w"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bda3b4318dso181018eec.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 23:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211811; cv=none;
        d=google.com; s=arc-20240605;
        b=HymlaGkTonTQp/D3+Y+j3DNhUGO5UFB/fE4GZI7O0NDxqUZer3hZfAeC7zMa+kvw+Y
         pgG/XWFT+YRUSxLOa9w92KWFylIDeVX33jb02PjtDT3trvzLBeHlR3jUObNGRsBfkxBC
         OKklu/Jm2rwaS5KC2NyqWE1iqqCMXYQyKilGZNHxzmS4gk9p0irlQPoVUzfZIr8t8TU0
         gRUKDFMWuB+4B4f3l/rnsVLszHDmcGc2BiyE+5v5zFvKkXroylZKA4eenmzlQvEDZYe4
         +XqSvhQwinUVGuYIRA0JuZFIK2j542pqQl2sB6bhCnDlTRVWrWjj9zcrtaaS7tpDftVA
         WhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=onL/29YY+z3OqQKGXwc+lgSAlaeKX4jIOj2ijHlD2qY=;
        fh=/5kM+R/VZRYC/CnzTwn51TZbkociEkitulEqtOKkhv0=;
        b=PKcVdHiUNv3efOAiM90RgqanzrubY2z+/kEmVQxQKE4TKVieETR9SxRzGatRF/anK0
         pSpJWX8AlDhMMVae8JNMxQy4nJBMTV4gXy8xPtmHc8Nr7fVsK82HIF4KmhmnZ+UNbNrJ
         4lQtrJsA2aZwUO5iFY+Yl/ayvf5zb41cALvtN9mTWn1zfFQkEDxTsQgZdzdFHbXTQ1+I
         kOQCq4NzCAWEVU61Hg5Y/dpL6e/i+vjslS+nhh4P8PKGZBQJTLzaaBcSV9jy8h6IS2vd
         e75poNYttes7AQ1XOB4bKU3VFXSS43Rg34xaklfaTx2tNOz24bP34poTqEg+lfVB80q0
         CfDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773211811; x=1773816611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onL/29YY+z3OqQKGXwc+lgSAlaeKX4jIOj2ijHlD2qY=;
        b=QlV1vb6w/k5UewOYNxqmn8q54QUS7tBIayQRqG9oLmaqF2/u0IL40aLOwjpdcveuKr
         8fhg68NkjhZlrVkZPfKnpuBcV78Vzi+oKnUav3go0tQfVRE6XzS6FAoEjyX7Zk5amzoy
         T1dkmxuod9hHALhjcw8LEDDm8ga5PrB8tK81lFcculThPBSZWYX6pMXYFjAZaue+F+Ua
         lex1a1ZcaBvJOVYuduRMbkNUZ0CDOoRi4t/dLSTlU496t/s3rFO+vvU1+1jat/h2vBZD
         EDj+z9IDiC4ZhhsRs1Hl14UdNewbnYa/+kFx2LjW2MangE2MM1oGQI5/QyXVysFl8Em3
         cO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211811; x=1773816611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onL/29YY+z3OqQKGXwc+lgSAlaeKX4jIOj2ijHlD2qY=;
        b=h7EU6/Z+M+lZTMBSUqhtMEhXCL0KiotLP1O5tSwwqlN+rN3qZK2/lXfZpYQAxRPcdS
         qfjj5KC+mRiBFEDr/X/8i71P4/n9hcbUPDrtaCWw+jIaOxWYITvJkwGRdpRMuycnlKp9
         03yGrF366b13zGgZFl038nnDbSRGRS8qZUXGevf3CMJczN3cXT6zgt5cMSlhSoF1vkKt
         S/Qu5oWrHYUxKv/d9u8USR0osh6Ku0XOBIYD0wEMdgw2wWgj0sv8FixgT/KPKVNXpVS7
         ZCPqI7AdyOL6DQ1HumkRl1XNdiZRdp2nTUAifnvM4WbS87v+FG2Lb7sdR/a5L9LOkE8N
         gnEw==
X-Forwarded-Encrypted: i=1; AJvYcCXAjKntuYlUOHy/Vg+NdmUPuT/ptJljNuWfCvV4htKEA6W/e0k8sKS20HZC34Nbn43xwPQIs5UoGBPJfSETT5y5QLlnlt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsrV+qJ0JGsvnNu3tt32NoJadRs7VyH+irY3nSOsKgizwh0HzI
	H1P/2EFtVd3pE4cb9bTNEnICl8MLkx3ApElOBXSYNo8JqGRLPeZ0sVVliWrTXHT+nnDMfxOfnJX
	9ar9blaHlSM7j60IUDGaZCWUI41jaqs4=
X-Gm-Gg: ATEYQzwIzDk7QPV8ExQuvrDIT1hy/rrurCwEl47eVCTUlV5hhC2L/tH2YtKHQnZ39W5
	Dhcaw/JXBe644MJ7UL2bAzN+k+C0FGn2n1WQoI9H4JJTpu0S4RZ3J+83xB4Jkf4Gt6SvzcgFj2w
	uaw94+tNcylkAtvm9lplC+Qu6soErHoExAGW6ShsitoANhroeOAOWlBf1sn9TDKan7vNayCe9At
	TS6DguCANe61Mtx/1D2aQzTuYzSZUvozaE1UzxwPzBNyZ2JvCaLgbQYqMkVD0Q0RxhPBm1/YWcG
	31sfS8v9+PGyoVqPf06zx5Gj9C0R6DEgzZep+jKtTv4LwNHGqPK0r43/ZKSlZO5Cc/qQCtg/2vL
	iPi/CE33Ilfb5JvolrHSp+CJ8Co0lIBTPRQ==
X-Received: by 2002:a05:7300:ac83:b0:2be:171c:2177 with SMTP id
 5a478bee46e88-2be8a59452emr284520eec.7.1773211810978; Tue, 10 Mar 2026
 23:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311050854.657422-1-jamie@matrixforgelabs.com> <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102019cdb4c705e-7d46b4f3-5cbb-4a6a-b315-e10f182fa987-000000@eu-west-1.amazonses.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Mar 2026 07:49:58 +0100
X-Gm-Features: AaiRm535x1Hmgg5YQnGj0LKUbOS7PktnidqhuF_Lvh_lDt_K0GP48DPWZ8EkWYU
Message-ID: <CANiq72kLu=t6M4QOYbqByG05+TpwDVO6iQRYDXJuFq1MudKsZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: kernel: add LSM abstraction layer
To: Jamie Lindsey <jamie@matrixforgelabs.com>
Cc: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:09=E2=80=AFAM Jamie Lindsey <jamie@matrixforgelab=
s.com> wrote:
>
> Assisted-by: Claude:claude-sonnet-4-6

Thanks for disclosing that (I think the cover letter was also written
by an LLM, right?).

Without taking a deep look, it seems heavily LLM generated (em dashes
and all), and it doesn't look like it was reviewed much after
generation (which probably led to the missing SoBs in v1).

For instance, without reading the code, just from scrolling through
the email, it is clear it doesn't follow the usual Linux conventions
(or our Rust kernel ones):

  - The cover letter lists the commits at the bottom, probably
generated by the LLM trying to be useful, but Git already does that
immediately after.

  - The commit message here mentions "This is v1", which isn't true.
Even if it were true, it is not something commit messages would
normally mention.

  - It also mentions v1 and things like "Planned for v2" in the code
itself, which even way more uncommon.

  - The docs use section more verbose, custom headers instead of the
standard `# Examples` and `# Safety`, and doesn't use intra-doc links
in the places we would normally do, and doesn't use Markdown
consistently.

  - The imports don't use the prelude nor the kernel imports style.

  - Some comments aren't true and they aren't needed anyway, like the
`bindgen` one.

In particular, since these are Rust abstractions, I would be wary of
the soundness of code an LLM generates. The latest models are very
powerful, but I have seen even better models that the one used here
generate unsound Rust code before that, and for easier code than this.

For instance, one of the non-standard `# Safety` sections here seems
to apply to a safe trait for some reason. And I wonder if the custom
header was used by the LLM to be able to keep its own explanations and
yet satisfy Clippy...

Anyway, the summary is that kernel code can be assisted by an LLM, but
the end result should be as-if you had written it.

I hope that helps.

Cheers,
Miguel
