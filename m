Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OOhTtmS/"
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B9170F
	for <linux-security-module@vger.kernel.org>; Thu,  7 Dec 2023 12:07:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db537948ea0so1456086276.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 Dec 2023 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701979648; x=1702584448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWWx2X5EKVBT2ik8RNeobD9aXUGmS5cw6HelRXHUt0Y=;
        b=OOhTtmS/zd/xbYlsrFNvhdshu6HikXSG8pz6R6NPC/DhKmWzUN85qvdP+oJC9iZ7mY
         w+t3k+NqNIPycz/dhW1sp/caABieR9x5ojgfau44yWvafqHmjojid7n9ISCsdGdoTAQJ
         IvmlWg+c10OoGsx0v+adQDBu8GLJzAM4OFZwdsZ4g0x2fPOHjyr3f7cVGX5nfaMWtFej
         aDiJ2QkstV4FwiyCR9S3ii2jtmnEgj5YGGX1jCGbeSL94V44F3ndZP2sXNFPwytHDrKB
         C8bFjt3P2Gkg8KEYGPezOU8hgOJowhiKCPWQKzi4WpGn9WSsCE4VGLewmnBPRH2GJEDe
         WfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979648; x=1702584448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWWx2X5EKVBT2ik8RNeobD9aXUGmS5cw6HelRXHUt0Y=;
        b=OCndIgYRHttbVRjKyShyiV3whSYdPPf/52NqDYyhkeg6PqwPUM6faKe+JOnQ5xjSUd
         r+Sd2lJabUzMTqWSpG1WZonMWHnV7NGU7xTVwx9GJRKqI3hJTQeUJZa1yvP8CsZKi79r
         7diyLv3fK6Ef79tHKyHa6EiW+L9FGcS40n/B+uvpoV7ZNfPdeA9VsH7tXPMZR5HPC8i+
         OpaJfXru5dkwoj20x6uYpDpAHRB6RdnMOfUIdKRehWno5RxzHOHERdJWSDuvVbxZAPJ6
         KeoMwIldmC0TqpOx2qBoP7jUJKY36Sjhm3jsti/38fq6FqFOeoCDViVSxdyK84YRi5Bx
         HP+g==
X-Gm-Message-State: AOJu0Yz+b4dfVeWYOIGjviVGAZUjmKk7iLAWNEeKNQ9p47O9Q6cr5O+l
	iADF4mflB2CfN6YptEDo2b1tauTvkIGMbQt10dS2
X-Google-Smtp-Source: AGHT+IG5/rfQ7VOYEbjBCN4z3iR1f+9ch+DgYqYY7IQnxs9sgR4R5gv+dYWcIh0/BxhiyVctY7N0GyyZ5mV77zvS90g=
X-Received: by 2002:a25:2f4d:0:b0:db5:449c:5ebf with SMTP id
 v74-20020a252f4d000000b00db5449c5ebfmr3001755ybv.38.1701979648614; Thu, 07
 Dec 2023 12:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
 <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
 <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com> <20231206075529.769270f2@kernel.org>
In-Reply-To: <20231206075529.769270f2@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Dec 2023 15:07:17 -0500
Message-ID: <CAHC9VhT2Azgxv4uL0+Auj4YtOt3cm6=yNnZ=Qihfd5NNhmi4uA@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in netlbl_calipso_add_pass()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 10:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 5 Dec 2023 16:31:20 -0500 Paul Moore wrote:
> > A quick follow-up to see if this patch was picked up by the networking
> > folks?  I didn't get a patchwork notification, and I don't see it in
> > Linus' tree, but perhaps I missed something?
>
> Oops. Feel free to take it via your tree.

Okay, will do.  I don't believe this is a stable candidate so I'm
going to merge this into the lsm/dev branch, it should be there
shortly.

--=20
paul-moore.com
