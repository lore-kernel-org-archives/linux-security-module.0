Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21C379EFE
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592148; cv=none; b=I/VHNNkWHYntMKdkJvMJaW8LnDsS643gB4HbAl4T5K7a8xNYhjhSI5rHxZlOLdJ4qMJo/peb3qAxm27gb993nwwtBzKMx673L66tV8yuSfYO4CQjNe3ns/868D6HAfJAHA+c6KiiD/CPUXmZZrov0TbeFdm7ssJTKcfpzbGD0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592148; c=relaxed/simple;
	bh=2CMcW2gq2LmD6OBr8KShORwyqyftbdR5TuaGADyZZ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmN0su9k1+EnhIIAMhjLBP/o4DlL90KHsE8zvEnqsudndUPJLxXrtJbc6G2DPyas23Pk5X6udTYAD+KK5rgQ2o9ERSVNtL2YujSmqnFCtVq+EA5KSk0Ly2FDj7GT76ZAv3DXvjTPxWucQ9nbMu2e+HyD1qSlnOFEQdhpRFZC9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enO869OX; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enO869OX"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6505ef94043so2944771d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592145; x=1776196945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+Kz9KQLBOk2gZAk6F760LWdEiRy/BzHmk2mLo+ys2U=;
        b=enO869OX6+lKrCmPv3YMb9cY5TbheaTdV1u7lyE15BBCMX6+/kAW7K9mixbvUXkDOk
         Mosep08MeJflR2syvhe+4O/2FLii7ORtdQxHAafrfgnnGcly2EBeLZ+Za6bth08mGIBJ
         u7hT40BbJ5hnnkMsz7pBBCRmcP5a+//tdvHNZtznHKMKPqWXzOPl6qWDZQ0MmH0y+AnD
         Fp+xamww3eMWMeZ/mPXIkGkLoKupbX3ad3AwuUe2TBzWhQQ2GbraTTZjXkhwQrJB2FdO
         I1WMDga0aCrUD5X6hM4FnP6EE6kpUC7GYL6Ex7Ab6uO8qWAMmYI9Cdn1cGz3DSEiiKJP
         V7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592145; x=1776196945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+Kz9KQLBOk2gZAk6F760LWdEiRy/BzHmk2mLo+ys2U=;
        b=i6//jLUKHumj9ASlWGVLJ4uXLdJC3Q7sE3aJrB0oEvvY9HopjsH8DdZ7tiDUcPhEB6
         T761SySve0jKzmHLttvR3GPdjJxnT5iGL5tKAuyFOh/bC48O2dw0/AmsD8xVl4wtpOZ5
         fgEd47+4qy/SY3Ku7/mvscr259fkojodhbtjmU5dZwRC6LGkCZFdo6l5GLr0Zad9oea7
         GbhHDfXUyj2I2uvwX15VDA6HEwrxM9bVv0ErLGAwNRJlDfL2xwdj+n6lo2BKm5pd35Mc
         tD2vh1VHJWDVcFJZMozWuJrHdzTFJDWR7+4tHFz1KQSzj0/jLlKlnv8AfK9oDuqvCWaX
         zmKg==
X-Forwarded-Encrypted: i=1; AJvYcCUALV7Mc9jv2Qb0tMWJ9E9245UeezBNt7dvmV3ze9StI1orMzE3NKhSKKC6Mdfqf6OCwMC1of+1WwkXE+4zeCsU59bZaW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywppuob4LuiXi9C+sXbyUtPPE+3phv1/Vg/s6AhCSt9p1vQ2iNe
	Ko9RplAQwFXY6zva4SXpGzxfcm1WZCoAh/I6RIa4I1m6h+yOysJz90ok
X-Gm-Gg: AeBDiet89Up2ueCVrMvX4JKjmdZAtkV7lZUJOOdX3Y0dk38wiPitmV01Bwk27S3wtbf
	+jpR9c2u7Q2JcQmJIVnOrOb3f1hzqevK9NVwC8quBS6BjMHpfLRBuNNa1+mx+PWV/QRvM299ivU
	UGIhukzpE5sD4fNuPuwsUoaYdB/SSMr9ynSaHUd0TAPwwwu6wyBMRTSHr6dmRgxAGzHBSnmOoWp
	7q9UbbSQ0dB+5ROVu4NzuPKJyGn8iFj6W82B9+De4TFBN9etg6o2X2r4/2jfAWFpU2dwTVcGfqX
	cWaQiSehVEyCPzNHORr5jjFZwi1DvoZE5yCjD+p7HWvrtq66PD2CTz7wc6j6wbi4l1Yy63LGxY4
	SZYPpiYPRDB8tfLjGbk83B4XnTEJqQZhHZayUz8J7MIQmRuaHD3h/qZGC/GD6OYk72dX61uYf4S
	iQydwSl4kcx7l8s0jIjAM+8TSrc4b9ojnCNb+2NqJqxtRIS5/qz4sUBm/cBWw/3gAfbCObUdGX
X-Received: by 2002:a05:690e:ee3:b0:649:b31e:8f48 with SMTP id 956f58d0204a3-6504871787bmr13350525d50.22.1775592145445;
        Tue, 07 Apr 2026 13:02:25 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:25 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 07/20] bpf: arraymap: Implement Landlock ruleset map
Date: Tue,  7 Apr 2026 16:01:29 -0400
Message-ID: <20260407200157.3874806-8-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new BPF map BPF_MAP_LANDLOCK_RULESET. This specialized map type
is designed to store ruleset file descriptors, and uses the exposed
Landlock helper functions to ensure that the ruleset isn't freed
unexpectedly. This map type may only be inserted into from userspace,
and only with a file descriptor referring to a valid Landlock ruleset.
Updating a Landlock ruleset directly through a map is not supported,
as there are no fields that can be changed, but you may add rules from
userspace as long as the file descriptor is open, or replace the fd with
another. Elements in a Landlock ruleset map may be deleted from
BPF or userspace. Looking up an element is supported only in BPF, this
is enforced with the map_lookup_elem_sys_only field in the map ops.

Reuse the existing fd_array_map operations for inserting and deleting to
avoid code duplication with existing FD maps.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/arraymap.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 33de68c95ad8..f0da17e0e23e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/filter.h>
+#include <linux/landlock.h>
 #include <linux/perf_event.h>
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
@@ -1458,3 +1459,69 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
+
+static int landlock_ruleset_map_alloc_check(union bpf_attr *attr)
+{
+	if (!IS_ENABLED(CONFIG_SECURITY_LANDLOCK))
+		return -EOPNOTSUPP;
+
+	return fd_array_map_alloc_check(attr);
+}
+
+static void landlock_ruleset_map_put_ptr(struct bpf_map *map, void *ptr,
+					 bool need_defer)
+{
+	if (!ptr)
+		return;
+
+	if (need_defer)
+		landlock_put_ruleset_deferred(ptr);
+	else
+		landlock_put_ruleset(ptr);
+}
+
+static void *landlock_ruleset_map_get_ptr(struct bpf_map *map,
+					  struct file *map_file, int fd)
+{
+	return landlock_get_ruleset_from_fd(fd, FMODE_CAN_READ);
+}
+
+static void *landlock_ruleset_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct landlock_ruleset **elem, *ruleset;
+
+	rcu_read_lock();
+
+	elem = array_map_lookup_elem(map, key);
+	if (!elem) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	ruleset = READ_ONCE(*elem);
+	if (!landlock_try_get_ruleset(ruleset))
+		ruleset = NULL;
+
+	rcu_read_unlock();
+
+	return ruleset;
+}
+
+static void landlock_ruleset_array_free(struct bpf_map *map)
+{
+	bpf_fd_array_map_clear(map, false);
+	fd_array_map_free(map);
+}
+
+const struct bpf_map_ops landlock_ruleset_map_ops = {
+	.map_alloc_check = landlock_ruleset_map_alloc_check,
+	.map_alloc = array_map_alloc,
+	.map_free = landlock_ruleset_array_free,
+	.map_get_next_key = bpf_array_get_next_key,
+	.map_lookup_elem_sys_only = fd_array_map_lookup_elem,
+	.map_lookup_elem = landlock_ruleset_map_lookup_elem,
+	.map_delete_elem = fd_array_map_delete_elem,
+	.map_fd_get_ptr = landlock_ruleset_map_get_ptr,
+	.map_fd_put_ptr = landlock_ruleset_map_put_ptr,
+	.map_mem_usage = array_map_mem_usage,
+	.map_btf_id = &array_map_btf_ids[0],
+};
-- 
2.53.0

