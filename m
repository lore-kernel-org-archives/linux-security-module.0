Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqhtnYaW"
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E310EB
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 07:51:37 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a1c915eae11so350711766b.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050696; x=1702655496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQQhASvSHEVVJUGZcFZxCWmvl8oJFIsiHif6PfFONLA=;
        b=wqhtnYaWZUBS7ooaK+RE/d0d0kJRH+HdA5ddKoZW/HUmDEWwnz6W+zfDowx2T34Q3T
         Pe0/YKPuphvy93WgffLCtT5vili9H2DNhk1KcJIxRpK/XCd3TiHpuaGfwwT+ohW3PEsv
         5+Ctje39iFX0LOsMOoAZOwL5A3Jn4nML5UuEwELwNJkuZQX/ls80MjrX0XMjugCWl7QF
         T6k00JnvV8zPhO0la/DdMU8/skm5Ia0yswVk++B2t4zVxF1CWSZ5FUKScC/wkfgNd6rj
         1gB6mvF/OwK3/+p8m97VinTfTHysiLj3S28GwEAsFyDnJA+eiCf9u9zgDl92Lq9vo1L5
         xl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050696; x=1702655496;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQQhASvSHEVVJUGZcFZxCWmvl8oJFIsiHif6PfFONLA=;
        b=VPPV7cK8czAZczc5/NwTpPOpP3mq/NNNU7xS+auYfrtxP1MTu8NK9Az51Lg9T8l7wx
         XJl4k3xL1hX7tCLEnbRqMvRdefSqxwfCqK9YgM/LpckKEAgycKY4NCVtp9C1lw8R4JQq
         7rsx5hSr2q6ofp3+iGP9saPW+9ZRbm5EpWv5tFjAcMhyxggCqiCVSb2ewZAqOENimrxZ
         0e+gu7JG1S93h2r7AvaY1Nwgj2ga5o5eGKxc/BEYOPVCszS/LMdnFkba2uqfQTmfBchV
         zFTLiwiak9KCpGBrvFqaik2rdHHGqb1LFjoq/yvI1xsBPATJmOy9HgeRbAMY8UWLPK5i
         +FIA==
X-Gm-Message-State: AOJu0YzCdavjek0wwnVEcB+3JfILq7E3DU/NRVmG9NrAouR6MAszOZXk
	cASoKsLl8J7bq3npd3/T+GE5c9TfaNJpkk1eDH6ptDGzGATaKI9E+R7D4ATry7zguTKWK5bSjOQ
	mjgi2J6AlrYJQBcPdV21ICfzKT5dlkmoHJfUvPwh5g0tK9Z7Tf3bhChnPkYwCdVohk6doyEp7YG
	WkZZM/yw==
X-Google-Smtp-Source: AGHT+IFpaD++LK4E7OEiQC7I4oXVtYGVHw5pHI4ByxvRkcjujlRVCN4Pq1RUgImtFRqk9PUtqPZi4UFPhls=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a17:907:1b20:b0:a1a:36ed:f807 with SMTP id
 mp32-20020a1709071b2000b00a1a36edf807mr14369ejc.2.1702050695110; Fri, 08 Dec
 2023 07:51:35 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:15 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 3/9] landlock: Optimize the number of calls to
 get_access_mask slightly
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This call is now going through a function pointer,
and it is not as obvious any more that it will be inlined.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/ruleset.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 789c81b26a50..e0a5fbf9201a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -723,11 +723,12 @@ landlock_init_layer_masks(const struct landlock_rules=
et *const domain,
 	/* Saves all handled accesses per layer. */
 	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level++) =
{
 		const unsigned long access_req =3D access_request;
+		const access_mask_t access_mask =3D
+			get_access_mask(domain, layer_level);
 		unsigned long access_bit;
=20
 		for_each_set_bit(access_bit, &access_req, num_access) {
-			if (BIT_ULL(access_bit) &
-			    get_access_mask(domain, layer_level)) {
+			if (BIT_ULL(access_bit) & access_mask) {
 				(*layer_masks)[access_bit] |=3D
 					BIT_ULL(layer_level);
 				handled_accesses |=3D BIT_ULL(access_bit);
--=20
2.43.0.472.g3155946c3a-goog

