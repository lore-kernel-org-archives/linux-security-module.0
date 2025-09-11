Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081326E71C
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609797; cv=none; b=Aij9mySkNm/Lfq31tTgTbX/FmvTdXC1LZa0Pe2zzYb9fR1rRejC/YJz/Z9mnQ2w1DAy738bVe62cNJ/gG/AZQ1XwQADpuAhxUKsk7e65QL7JgDVB0TJ/jEumwPzKPjvUmgrazuI3dYKBlwd1rnKwvPXGpPGgBdr3j4xzmXFF+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609797; c=relaxed/simple;
	bh=xBZRVz6PARR1TaFj3HxYN+PJibH+tkD4Ha4ojpsPTRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuUylVHIlq9Srz/sFxbdeDz4Q/40s7S9/31afcEu0pZYGjiiLrWuNEntOUvF4NQS5cvjYqjMfiyjX8nvXl/tgmmQbhn2WA+eqN+CIWkw60xAt9NakGHoTj0uZ58b9qngg6kTedh2nK0q+0xiQKyJ1fk7dhkWIk9oaNuRMReqPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ma5ZUBIu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ma5ZUBIu"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so1614211a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757609793; x=1758214593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPti7ycwxDijfbNVdZ7d+tzQdPTkPvICaHZpGK8FY2E=;
        b=Ma5ZUBIutfkFbB323ldP8hGdEfD/5e8AMCKaSS6ZknS0otBjXaHITk7IXeZhB5Qbq0
         /ohOYt05OLhW35B6VHJusEDBJa7Ugaxl3b4w3OtiKlpRlu6Ub6CxDXSWqW7IBEIifASo
         WD0aJcqdDADhfRRjTSfWz+p6LBdWqLDPlrNQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609793; x=1758214593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPti7ycwxDijfbNVdZ7d+tzQdPTkPvICaHZpGK8FY2E=;
        b=iOXnuGYFhoQmIDwn890ghggfaLYGUVxAaTTaK0rPtSCZR9fVHHVgKpflANTbWHBMfJ
         xQQq3qlRYpI2ZddNrRIXaKfnm5yVYogwdQMHpp7qs+pyAWLvGi4tYMxwNz7H38DTsdnM
         LZLFZmVcjspE/2bJ82Yggj5yLW+HXGwDxxlTOLjDS06GTlbNgyumDDdRO10tiH9KkjOh
         cPaSI8dDiFhoNSMwj33Ev5k88axoeqo4eA6pk0hA67zwUcGcSQG9dDDU4VXzc8i9EmJ3
         QIfCdljKg5SPpx23NdB4CGANfRIH1Ui3bLUbDh7j9vRzFI3a6xiOCbos+QyzthMMFgOu
         EwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgMXIfKVaQDNsU+q0Zbf1JfKPSpHpNtMGVuGKrCGyxla1kA0fs5/pFxGdYjklHmc7STUw8DNHf+4rzTcxlgAqM41EWsMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfD+uMuHvSw94DtR6EDIRElY/h37W+uMyP6za5Vnegvt4WBeE4
	T1viClqh2O5sRcnCeaDbupH3ajr5CbdZ05KgXUPXIQFVOuomQSz0IUET03ljlSmm48L1MZ1J4DV
	ww4Egw8k=
X-Gm-Gg: ASbGncvpKjSfO+ElxXNQTHm9jOy62Rt0rOLmLvmAz7BPGNDpH01aXd0blssKlgfEaDw
	QZahBc/sHmFSTuq8qFLN0+jGDeUrkYMChu9W5UbHuDC0dxcKFas59znLXgRcABay1sHz/ICEB2m
	RPfM4zD0EDz+AOkRWHhTZ4fK1t88oV4bFb6Bbr4f7FWFB4MSdQ34jcEtWiGl8qNl2oqyG7Oukfv
	10Mzsv23m2XNEVq3fhSVkqYSS4VBvWHjPcIIbV7eQOpKHjUfovRd4NB/0P7BDR3O5fXDxUEbCWP
	70EgD4drOrN9vAzMKmSaPoOXc+BlZlr6NgAk/KRgTFnrMmrpAflhWYZ+gqdUAaOGWWIAMcZgf1Q
	FxrGo00XryU1pBG2gDsxxBWIA9BmXXsUPVIvZ0LaMeexf/kD11k4hgM7LAAN0CjZ7afNc4DV+
X-Google-Smtp-Source: AGHT+IH6cXlZPYykuuWXwYACRV9vy72H8TkoqM0LjStB6cormhTpS/ZJsqJVgsZeKcSJcaemaFl4RA==
X-Received: by 2002:a17:906:6a1e:b0:b04:616c:d746 with SMTP id a640c23a62f3a-b04b14aca68mr2246011866b.25.1757609793258;
        Thu, 11 Sep 2025 09:56:33 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f202dsm166341466b.84.2025.09.11.09.56.31
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:56:32 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b042cc3954fso178439666b.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 09:56:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsrRdqoPWI5HTb5Nsp5uId14kinl3Jhlmk0T+m2XUAZ0hY0RadlomNyLNrivGsTFbXZ9aH+HDbWFwzLIROczmZxKHHUos=@vger.kernel.org
X-Received: by 2002:a17:907:6088:b0:b04:dd2:6075 with SMTP id
 a640c23a62f3a-b04b170eacbmr1971744466b.49.1757609791574; Thu, 11 Sep 2025
 09:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911050149.GW31600@ZenIV>
In-Reply-To: <20250911050149.GW31600@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Sep 2025 09:56:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6HFD7d_phQS_rsYjQ9xRvXuNCyV=oGy26d6iYt6iiTg@mail.gmail.com>
X-Gm-Features: Ac12FXxicQ4WAB4cvULD0gaIeOT7VeyW2uyyl8b6G93itM1wZRd7N6oDuOhRH6o
Message-ID: <CAHk-=wh6HFD7d_phQS_rsYjQ9xRvXuNCyV=oGy26d6iYt6iiTg@mail.gmail.com>
Subject: Re: [PATCHES] simple part of ->d_name stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-security-module@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 22:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         So let's make sure that all functions we are passing
> &dentry->d_name are taking const struct qstr * and replace
> ->d_name with an anon union of struct qstr *__d_name and
> const struct qstr *d_name.

Ack, all these patches look ObviouslyCorrect(tm) to me, and seems a
good improvement.

Even if it won't catch the more involved cases that worry you more.

             Linus
