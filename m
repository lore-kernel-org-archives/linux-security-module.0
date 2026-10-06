Received: from mail-yx2-f33.google.com (mail-yx2-f33.google.com [74.125.224.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4332D7398
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246061; cv=none; b=Xkl3UJDXMXtQXBt1ga7W0PR0qRn0kB3zM9eS+rjhPT6BRLIOvf56S84l2Zud2pt/ErJHmUbE1ttANOicXi+0z7/xSQgoNfo65u0qgvVvsFrSM+Pu9eExPN9YJFc3QfY4AyLFU3F+WbhOceqxf1EjYSpHbFya6soI17Mkcc2rD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246061; c=relaxed/simple;
	bh=wMJGYrbUj4os94fJj06zWmFNGCmeZceTo1G4NZWQtDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L73yKQ2nt+NTkZ2nnhsvGa5codERsrpcauBGJ84pdiEhT05Bv11PK9zJKRQj9DVJWfdzh3jRKIUTF+p0rIBQvgRVvJufoNNRCrBaNB2jq1xsJzQDRAWkGXoLjawAf3wyEYkQsyZEl9c1m80zsr4J6xoHilrVzBjAJigLCSp+iKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqV89hbz; arc=none smtp.client-ip=74.125.224.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqV89hbz"
Received: by mail-yx2-f33.google.com with SMTP id 00721157ae682-8ab41af29caso18194347b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246058; x=1791850858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0mktHpoo7c1ELqyZ2fb0sw3f8VVRQGSWUHz0tOcBE0=;
        b=SqV89hbzavHhGIssD2p5AQHPnfCwLN0yMUWNtydRwTqMcmkjHWN82v8rGu7rsnlww+
         ceStMO1zrxDwScDe6AyowqiXy3JePIoIdxZw+1u4psoPN7zBztjnbbt7Z82ix8/R7r28
         Pgxa/Wt4iaegw9bU9FJGg0QjjpqRRMq99cWwS1oAK/xueB1PVav7R7AyjbiSpmlmGgdy
         ddgE+MThcmfq2Qocvmdtxpf3szPhbgLQvkslKE9cIlzGHOcvBQQ2WzBh+GJbWitZsOJN
         O5Y3wAjta90PEJHAbDHSzdYX0t65gZEH9spyGFkawCLfEIr3cxGTzIDkMWckeWJ9EKo7
         oxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246058; x=1791850858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0mktHpoo7c1ELqyZ2fb0sw3f8VVRQGSWUHz0tOcBE0=;
        b=IDhlhKXqEyH0Rb+FQUisDcpN67T96ULikNFw/Jq00nB468IsRSNgN07IiQtu4msFww
         v6Q42A/xNihK+OjVx6I5pJt0tnX9UADiluOeiWiT1oqiqnSomsrFiWaaztFIfMP8Xg9k
         WqpFS1UbsdjBgCkgAR/U8wNvF9B0Rl720NoNaSqB7wV2RbjaU4l/W/t624f7GzSKByvX
         YhQbwN8RITFq9SkddPIs2ZSIhmBFdpGJUCRJewmmr0rtHeYYZT/oj7DrNBW6i6Ug5aDm
         3ejjBKxVct9VsyUkW6rrkL40+QBOeKmApYHMJjr8ultVA0T0PZWh2NJ3t2BtRWllLKo2
         B3VA==
X-Forwarded-Encrypted: i=1; AKwUvBwEvvUN3uV/J1OD/TnRAnhZBGtPR2tJMJ5xa+UJyFl0596jzPepmaHsTtgsNOqiPHmMdKJHT7Y17QsWVVw1RvuLAnVH/lM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqTD19sdvoQ9HVkLDGP6BBKyTcjbwnDFxe7iElttlxGfbL8Z8K
	z5ff24bPFszIcuN11VUA3B8bK2v6M5SMB8n2zYqG+64kFRSg2Qg1OZAQ
X-Gm-Gg: AYBFou0xm+/86GN94XDpNmIFJVjRO+k/QG8hZEccYs/FSvtoydmzmGavuPgucr6Qv1X
	IJKdGNYJ5nuw4bC4Xd0DwvOPfMjr/0oe83MHs/hhBUkWyKGeSwMoSL5TtVnEhQynJESdjPTSBpr
	JnQNuBDvErtyjsF6WxhF+/yc7vMi8hTqOtv+TfIbaDwcAuK/6hrPsq+tz/zliCzn40FVU8prGN/
	FAdip3XH8iE6HQvFrAQr/kuu/zo9E0QnQ+iOToAzdOeEJlrWT1cLlMj23NqY+wyLufKueeN8ifu
	cqzIov/zPx79xko+EnGhKqXeDodALzkKT0FCG72aV76QfI+8GCyvHlqiWY1dz2RUfOuwNfClcuU
	7488IZsWk/A7GMPJTZv87/5DVqMY4FAEiJ0skVsvcpB4+erX6Pk3M/AGH7/0Ax6K2T8ORrwlu8j
	zc5hcT/yAXUqWd29CeFsFqf1WROv615URK483cMISg1WIYR22vT+dY0kljd2/0UDrbczN340pxb
	Q64fpHCuor7
X-Received: by 2002:a05:690e:d0c:b0:677:c87c:d2f with SMTP id 956f58d0204a3-677c87c122dmr2826146d50.15.1791246058500;
        Mon, 05 Oct 2026 17:20:58 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:56 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 10/12] bpf: support "__uninit" iterator arguments in generic kfuncs
Date: Mon,  5 Oct 2026 20:20:17 -0400
Message-ID: <20261006002020.2890858-11-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterator constructors are recognised by their KF_ITER_NEW flag, which
binds them to the bpf_iter_<type>_new() name and so to a single
constructor per type.  A kfunc that initializes an iterator from inputs
that naming convention cannot express - e.g. another, already
initialized iterator - therefore cannot be a constructor.

Let such a kfunc mark its destination argument with the "__uninit"
suffix already used for dynptr out-arguments: process_iter_arg() now
decides per argument, rather than per kfunc, whether it initializes the
iterator or operates on an initialized one.  Only iterator-typed
arguments are reclassified, so dynptr "__uninit" out-arguments are
unaffected.

The first user is the path ancestor iterator handover added by the next
patch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 066c4b838b85..3294b2a43167 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8312,6 +8312,24 @@ static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_DESTROY;
 }
 
+/*
+ * An "__uninit"-suffixed iterator argument of a kfunc that is not itself an
+ * iterator method: the kfunc initializes that iterator state, as a
+ * bpf_iter_<type>_new() does, but from inputs the constructor naming
+ * convention cannot express - e.g. another, already-initialized iterator.
+ * Only iterator-typed arguments qualify, so "__uninit" dynptr out-arguments
+ * are not reclassified.
+ */
+static bool is_kfunc_arg_iter_init(struct bpf_call_arg_meta *meta, int arg_idx,
+				   const struct btf_param *arg)
+{
+	if (is_iter_kfunc(meta))
+		return false;
+
+	return btf_param_match_suffix(meta->btf, arg, "__uninit") &&
+	       btf_check_iter_arg(meta->btf, meta->func_proto, arg_idx) >= 0;
+}
+
 static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 			      const struct btf_param *arg)
 {
@@ -8322,7 +8340,11 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 		return arg_idx == 0;
 
 	/* iter passed as an argument to a generic kfunc */
-	return btf_param_match_suffix(meta->btf, arg, "__iter");
+	if (btf_param_match_suffix(meta->btf, arg, "__iter"))
+		return true;
+
+	/* iter state a generic kfunc initializes */
+	return is_kfunc_arg_iter_init(meta, arg_idx, arg);
 }
 
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -8332,6 +8354,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
+	bool init;
 
 	if (reg->type != PTR_TO_STACK) {
 		verbose(env, "%s expected pointer to an iterator on stack\n",
@@ -8363,8 +8386,16 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	t = btf_type_by_id(meta->btf, btf_id);
 	nr_slots = t->size / BPF_REG_SIZE;
 
-	if (is_iter_new_kfunc(meta)) {
-		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
+	/*
+	 * Whether this argument is the iterator the call initializes, rather
+	 * than an initialized one it operates on.
+	 */
+	init = is_iter_new_kfunc(meta) ||
+	       is_kfunc_arg_iter_init(meta, arg,
+				      &btf_params(meta->func_proto)[arg]);
+
+	if (init) {
+		/* expects a pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
-- 
2.55.0

