Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361321C9FF
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404339; cv=none; b=fH4lsO7m13zgQnh7sSlKdg3MpeJiQiHaH2ZHrdtCZPr4L4hlrYx9sIb+WTgz3Fk5PylzHsGQL64HdorgzyUNqFyL2oeOXQXzddhSohgAAaXKanRyD+IIW9A42x4ADGcBYMp0dHa/sbuq78GU6/cNbl1lSA+BIKVGsAurSw++7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404339; c=relaxed/simple;
	bh=w6Ke9wv7LjR/4PFnRiWR5xnZ0BH+mtCxjUCYNIXimSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lC9iZZc9DOAeT0c9PPEBDTsnZ/pjqRk8ASwP72ZoHVh5ldKWKsGD6cWA6Y/qtYle0T4JHzrylKqcLvDIRuEd17g8CP9TlGQpFuKtByXnxiBg0CdFv14P0d2FdfFj7Nnr4QnRkpQOeoJ1H5rFcvEwJeCtBS1o6YYvVOLMeSvfse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fCdOkhe9; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fCdOkhe9"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7040987879so2251113276.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744404337; x=1745009137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6Ke9wv7LjR/4PFnRiWR5xnZ0BH+mtCxjUCYNIXimSo=;
        b=fCdOkhe92a+czn6r8lTKR1HFI22RNATPq9sn8vHZb/OYbO7ZU0jM6hmwYQOt9GEEw6
         Q0iCXhzSG9126s1ZEdyk6S7KHPlrnr7tFnXYZlIRry0R9wEW44meemrR8mSIC2UfgM72
         Cq2ajHPVhfjfzRzGEQQ6W+4dkYOchA1WSWeTksIIGqq1Q3kOcaWe/yBICb/juk3vbo+H
         oUcguB5VjkmnBqqfp13PiHUDAk9u5hLwzrZsVuxl2b/ESD4djfb74tU91JdKbD9uaUU9
         486jZlS6mJ5q4sgJeLbDThvrWYtH17ytD8QGyG4rW1Tvpe8g4xQ3JfBp1ptg/g8e7497
         msGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744404337; x=1745009137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6Ke9wv7LjR/4PFnRiWR5xnZ0BH+mtCxjUCYNIXimSo=;
        b=Wg0SMje9A9q1girxVyc1gOMCpoJTDdEW7sb0gAWez3zXeoCx2mk4yQyPAlmmhlenu7
         0br/H1JzsY1Map/lzX40bvzpzWoPMtJbATeZVp/8tD+Isl3zJ7pf+BuoAHv58K+Z7QmA
         h/RAFklm0XQV6ADg61v0wUi0E6mn89b3KjrUNw7tv1GXhBq8S1nCbP+8w5kygwoBvPsQ
         hnkAjZzjC06AZF517Xqo4dwGrF+Ktxte5ArMpHvhzM1H+rUYFBgxdnfRXmenP4kv9vMr
         UEBsWvL7dO4jmelvf4lg8InfkvcCubWTv1IOJq7dmVyG09cSprhSxK4RXYlbwUl8wcKu
         h1uA==
X-Forwarded-Encrypted: i=1; AJvYcCXzNUl21K5p2YOJLtJn8Nz2ZPOQznjKkO/43k0mk7jZGoOPQzesVrfmuV0f2aCpNFi2pkyMpJ/pZMcJrFxASzf5miDdbAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+uoOOsJdevSgKQcdIEFrfrcqN0bT58Fa6UjoCawNgktC0dLP
	bB5T658KkJ6NC3kDS7nLh26TjmG+WkJbKHiisbQiC/qJVr6A3IGg+Ci3ePrUnLJt14+aOQmuO/K
	qHMWpMzcIymX1UIo8eE40/LtSAHYbJdWDZ+zQ
X-Gm-Gg: ASbGncvtU+9UVP1dnMKOgt5/y3+gWvduAzcqItyNINGWgM5CdQrKg+6uRBThkUXK/v1
	BwsbKT/BewxmoYNTbvkWDYGBaqPkWSrP8NSJ/Z0B7dfo49ImVvgQ/tpY65A67/Sp/flbBg8DnlN
	enznTPR5TBS2UFOSJcLGwpsg==
X-Google-Smtp-Source: AGHT+IERD7EfEd4vcG+sH9/p55NpMd2VNX+B1QFTclYMresfzQTk4MDCOmiXBzyaq4WSjA0sy7Gh//Ms4ocoFVGvxPA=
X-Received: by 2002:a05:690c:20a7:b0:703:b8f4:5b0e with SMTP id
 00721157ae682-70559aa82e7mr59884407b3.28.1744404336823; Fri, 11 Apr 2025
 13:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-53-paul@paul-moore.com>
 <202504091643.3C42B66ECB@keescook> <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
In-Reply-To: <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Apr 2025 16:45:25 -0400
X-Gm-Features: ATxdqUEFkrL1sQ2xYg-xZSMKiA1gg-2u5EQBXUcwBefIS8-edyh-uTPNanoSGQM
Message-ID: <CAHC9VhSDR8A9S+dsy_KX5NwNKgq5JaWVK1m5rXizir6RMtonrw@mail.gmail.com>
Subject: Re: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
To: Micah Morton <mortonm@chromium.org>
Cc: Kees Cook <kees@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:20=E2=80=AFPM Micah Morton <mortonm@chromium.org>=
 wrote:
>
> Acked-by: Micah Morton <mortonm@chromium.org>

Thanks Micah!

--=20
paul-moore.com
