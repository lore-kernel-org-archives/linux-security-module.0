Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D527A917
	for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418951; cv=none; b=lKhy9xR0VN+aVlxbwM5GI4kDLht87l4LuVoCdmPJ6Ly8zftA7osKEtO84PlR4XApRHeTwpJM2clTSrujLPpEHiGUH8ZKhsIQaV7o6PCBHRdzm6STp3gOoLe3uFDGcXm5b61J5i1YlDuhbWGamkXncRF5U2I21zBIWi7pZLRaY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418951; c=relaxed/simple;
	bh=rGS0QPr/09kRB4IST4qU+ikhdOE5cmQdYP0Uuer0Abk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TL4QvgXuXQAEr0v9JsK7GZXwBbN79VzGljs0+BD8jNEMxBhVESISBG4g7heJ6VOyhPL5eHQnhdIb/ifoZS361bGDWl4VkOrsybIvvv5rh5zA5wIlskYnjVS0jNpaBnn8A8CGu4MoDrCx5HLh6uykK/xntgPWdXIvpdFYVUOuBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXm/WY1J; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXm/WY1J"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so1276a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747418948; x=1748023748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zErr14NaPV4E6J72+UwhYWs0JPsGCP0hDOHvFlHwRfA=;
        b=bXm/WY1JOT4gtYGTIt3Wemb6cMGuhruOyjoJuSZ8gAGqXRn4o3oAuDpLfHM64X4fFJ
         8IfLue66ZXs9w1a4OqlyzhhBeOLQkdn2Bg9a14grsolnAw4h8DlvoRdhlYw3v3AGTOJu
         lSSv219RiTi5Szt4pqPnzfc2MLKjEHMgALrjtjWaOxnLT2DpiUmmUGctlVfgglEzwz2C
         Vd4+KuJqMQfyMmxJQ5+g6Dr3iEf5dosHFuQ9QBxOK2rssw+A1sDVU3DajQE2HVkPnOjI
         BL9hKRVi09QDxSp+aWlA/A4Zva0WjradykWouHH1M8WWmGBZXQdil/Z6AfeSZvwU49ya
         RcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418948; x=1748023748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zErr14NaPV4E6J72+UwhYWs0JPsGCP0hDOHvFlHwRfA=;
        b=SW5JIFSXzPi06gRYUjZF4n5X7/pKCgB+XmXHKJ6ht3KH0sSNNHn9LrJJuO6fwbKkEk
         0+3p9EuoY0N6wdADaDFCW6qZJfm4ywOx7pfM5oaU9A9rnPRO0gdFHXyZhmn0OccgCcNX
         xokY2fCULHv1K+Yq6TOJ2VVykY0ALtd5Kpt74uBMSXZuIitG4rPSd/vcOi79h0EViDXG
         cPtw8lt/aRQoIg1Ijm8HvL4oLjWuQPPRlja5gyBMYlQiYX7py5xb2hF2zzOclHaicFN5
         dbxBhoBVZMpFTmckrlwuk/IAmtimn2iD14LJyRNEYldPggaZC2XHNjDmUxQSK2GNENze
         BlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgt74MkuDa6tqBNwH7PJMWczvTtCo6qlhgPGh4XgS7yB4UDQ17tt+c17EFKPS2alQ0TnwQzhCWIfVGMTJSwRN0+Mr9pSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydHYrRQuwSlFMqCa+xe54Z/Etjfx27sji2dSLRuNXEvB/2MVjt
	qYvHuRvhaIpGgwNrVNcfa+AWOJaSWocOxOHCY2naUx6FGZACMtawOPmQO29mZ+sVcJ+xoHDia3t
	ajOINIDVs2+L2pd9a+dMPpnKj2J07zpXq/r4Tk9Mh
X-Gm-Gg: ASbGncsRY1x3fR2urbe7iU+vOth6ldxnL8A/hqBdQKC2dVCXV7mlrgPDSGCU/OptQ8c
	fuYie/oQDwIYD/DmRIaeTL9+lUtVgcIdUwlnAJM7Ymki0Lh9ZTGGzV0dZRSot9pDGJ9Y5vaAJAJ
	PaFQ0zHsc5J75Swgxw/2175OdW/2JIX7mHbd7G2cBEm4BvJiE5TNC6v7SJiDfCX73B1Zsq1xQ=
X-Google-Smtp-Source: AGHT+IGnDa7m9aFXLxTwW8XG/RA9k967U8i6KOIZIfU5U7ERMqkoZyY31cHz6O+XJ+TMiqZHyQoF6udz8LkIEPLR5b4=
X-Received: by 2002:a05:6402:14d5:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-6019bf2f776mr7018a12.2.1747418948238; Fri, 16 May 2025 11:09:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
In-Reply-To: <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 20:08:32 +0200
X-Gm-Features: AX0GCFvQ5yyB7VeXyMHb0_GGNIfkJ8FEg23lIrCXszrFcypcHNO0odexRPRgrWk
Message-ID: <CAG48ez3WHp2uiDf66obvtgz1eiGQDokNwCUeouXzUsqbF8oq_w@mail.gmail.com>
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>, Max Kellermann <max.kellermann@ionos.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 8:06=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> Like, I think currently a setuid binary like this is probably (?) not
> exploitable:
>
> int main(void) {
>   execl("/bin/echo", "echo", "hello world");
> }

(bleh, of course what I meant to write here was
`execl("/bin/echo", "echo", "hello world", NULL);`)
