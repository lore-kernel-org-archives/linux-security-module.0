Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A62824A0
	for <linux-security-module@vger.kernel.org>; Tue,  6 Aug 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977247; cv=none; b=Xvkr3L8P8D3TeR4khtH6VQwbxNOKx74QBoLna1RX7XoPE6CZWfZeZ1/eh8xT77NJ60X6OOJIMHMTCkl9ZEubCHoAC4O+bjSZCA76GXDFjTF8wwkqw/IA7vAkvqVcdYKhCBzbUtH2IMmhx+5a7vTjZ60RDvLFDMvVBKsC4fotGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977247; c=relaxed/simple;
	bh=iNiCv/tWWg8EntneQR9N42nc9zfctX2Eyo2IjjLXles=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShJbhCy9M57brblb1S+HbMDwlK6SUYvLoY3R6QCbB5YAOJ7JyZuIreC01aZbmSsJnzu1T8eQob4oowwRNTgGTS0LWY3ka7Oa5FgdlgijfndZHEA2g7Wn6U3NbkekO2SSZBSzhwi0Z5kJAkSiDZn7DIXmoPhoHFEhfQ6Ijv5u8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcWmnBh1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcWmnBh1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so106095e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Aug 2024 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722977244; x=1723582044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpIQih8KvxtMB9HL2JerR868gTSsYiklZU/ALdGs0Ro=;
        b=ZcWmnBh1T3cR50P8jf/4o4C4/tRTOb+/Hlkq+NxStQjOMP/u5sopmXetSpXEH4vN5e
         E/8fl1YfpwEo9HeY9r0CuABdG9B/o+U9h4xuR8ZL2rhhNQeGygGtjfs3ECmb3vvSMBq3
         UIJnA9DdggVyWEnswIhApbGv2UZZCCpXjrnPpjPculC5ArZAt4WPYmt9bnyVP+5FaNY2
         VweiKqdjAIj5tRwmj5Db6drmbt1hbaU9SLbui4jWZO9tMUn83237rJyYnjXTvoPtf84B
         l+c/N8gYlSpLQ93CHMCwHW4ItNM6CrucP4BIGcCR7W3NAGvOQU6jeMlrGE0z4TQ3JkjB
         6QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977244; x=1723582044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpIQih8KvxtMB9HL2JerR868gTSsYiklZU/ALdGs0Ro=;
        b=p5zdruVtox/9PifgsOgGS9Ior66WzCwwG+73C/kd1qUcRgYGn+U07hByiXIu9Fno3u
         +oWPSlDNs7TYqHT+zFGXxR/cNop0jvYIyadTKaNCFeel12ir/XCjW0If5wTOWmaekelv
         kiT//XuTsldbjZWWrEBS+/l6gpv/8kF6kTftp1z6iAEDDrmeRtbzGO2at+e/oBZpkT6+
         yxZiEpKSpM+BQcdRH2VCaUPWylTOYcM0h3xlCdiw+3kPzRSt7crV4X9C696PmceEeTeh
         dopn42yaWOrXNm0CxjgWPY+aJJH6ryuMVVB3cljoR5VZKHCreNAawaULnBj8790bilWa
         yGbA==
X-Forwarded-Encrypted: i=1; AJvYcCUszzLN7X4DdoAlGWTjCNNl+ZYNGZvS9Wh4cDZ/v1lsMSPMlGe3rRj5lsMkZYmVJQQWsg1zB5X1/sBNmnKVUUFQdH3SK/9dmFf9RfkslZRfvkTeJAP3
X-Gm-Message-State: AOJu0YwSbB0jdMuiG4vno8UnD4nyfFGaUJAnB0Qi04rOUUvFgDjytzud
	FerXILhYT2aT9u1tnp8cHY4+SOLl/BOjqqZ0ZvAdEXbHDIx92tqHq0xCGtXlFnKa+26eFVZVu9C
	VLK6qUoOZuM8a2E1yepypDrQNZlF1ZxeihMfE
X-Google-Smtp-Source: AGHT+IFnLFSvEc9rWyHW8xXfw+Dz/FmVeodJf43WAbqQSInymwYsOkKLiGreK4c1sUiRw4gA7f7QLpsQN6QwUfSSKnY=
X-Received: by 2002:a05:600c:3d12:b0:426:66a0:6df6 with SMTP id
 5b1f17b1804b1-429039cb750mr267845e9.0.1722977243051; Tue, 06 Aug 2024
 13:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722570749.git.fahimitahera@gmail.com> <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net> <20240806.nookoChoh2Oh@digikod.net>
In-Reply-To: <20240806.nookoChoh2Oh@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 22:46:43 +0200
Message-ID: <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect restriction
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:36=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Sat, Aug 03, 2024 at 01:29:09PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Thu, Aug 01, 2024 at 10:02:33PM -0600, Tahera Fahimi wrote:
> > > This patch introduces a new "scoped" attribute to the landlock_rulese=
t_attr
> > > that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> > > abstract Unix sockets from connecting to a process outside of
> > > the same landlock domain. It implements two hooks, unix_stream_connec=
t
> > > and unix_may_send to enforce this restriction.
[...]
> Here is a refactoring that is easier to read and avoid potential pointer
> misuse:
>
> static bool domain_is_scoped(const struct landlock_ruleset *const client,
>                              const struct landlock_ruleset *const server,
>                              access_mask_t scope)
> {
>         int client_layer, server_layer;
>         struct landlock_hierarchy *client_walker, *server_walker;
>
>         if (WARN_ON_ONCE(!client))
>                 return false;
>
>         client_layer =3D client->num_layers - 1;
>         client_walker =3D client->hierarchy;
>
>         /*
>          * client_layer must be a signed integer with greater capacity th=
an
>          * client->num_layers to ensure the following loop stops.
>          */
>         BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
>
>         if (!server) {
>                 /*
>                  * Walks client's parent domains and checks that none of =
these
>                  * domains are scoped.
>                  */
>                 for (; client_layer >=3D 0; client_layer--) {
>                         if (landlock_get_scope_mask(client, client_layer)=
 &
>                             scope)
>                                 return true;
>                 }
>                 return false;
>         }
>
>         server_layer =3D server->num_layers - 1;
>         server_walker =3D server->hierarchy;
>
>         /*
>          * Walks client's parent domains down to the same hierarchy level=
 as
>          * the server's domain, and checks that none of these client's pa=
rent
>          * domains are scoped.
>          */
>         for (; client_layer > server_layer; client_layer--) {
>                 if (landlock_get_scope_mask(client, client_layer) & scope=
)
>                         return true;
>
>                 client_walker =3D client_walker->parent;
>         }
>
>         /*
>          * Walks server's parent domains down to the same hierarchy level=
 as
>          * the client's domain.
>          */
>         for (; server_layer > client_layer; server_layer--)
>                 server_walker =3D server_walker->parent;
>
>         for (; client_layer >=3D 0; client_layer--) {
>                 if (landlock_get_scope_mask(client, client_layer) & scope=
) {
>                         /*
>                          * Client and server are at the same level in the
>                          * hierarchy.  If the client is scoped, the reque=
st is
>                          * only allowed if this domain is also a server's
>                          * ancestor.
>                          */
>                         if (server_walker =3D=3D client_walker)
>                                 return false;
>
>                         return true;
>                 }
>                 client_walker =3D client_walker->parent;
>                 server_walker =3D server_walker->parent;
>         }
>         return false;
> }

I think adding something like this change on top of your code would
make it more concise (though this is entirely untested):

--- /tmp/a      2024-08-06 22:37:33.800158308 +0200
+++ /tmp/b      2024-08-06 22:44:49.539314039 +0200
@@ -15,25 +15,12 @@
          * client_layer must be a signed integer with greater capacity tha=
n
          * client->num_layers to ensure the following loop stops.
          */
         BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));

-        if (!server) {
-                /*
-                 * Walks client's parent domains and checks that none of t=
hese
-                 * domains are scoped.
-                 */
-                for (; client_layer >=3D 0; client_layer--) {
-                        if (landlock_get_scope_mask(client, client_layer) =
&
-                            scope)
-                                return true;
-                }
-                return false;
-        }
-
-        server_layer =3D server->num_layers - 1;
-        server_walker =3D server->hierarchy;
+        server_layer =3D server ? (server->num_layers - 1) : -1;
+        server_walker =3D server ? server->hierarchy : NULL;

         /*
          * Walks client's parent domains down to the same hierarchy level =
as
          * the server's domain, and checks that none of these client's par=
ent
          * domains are scoped.
