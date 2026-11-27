Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793622;
	b=AXwae1jgYcS3zAw0zwuahBxKxUVwkXqz0Hit6nloTOHPbVpB8QflzXpY+I5nf3dgTyw1
	 ijqqKnW0vXoaizX9/ia5n8uTpkHK6UiGAnE4XmlaRNVridHhIibOuwv5ZCkJrS0QHlL2j
	 VY8j6uafPmxApPpBttjzImMIE1ItN2g4X4Q6ofj/+8iK+QFmci6b8dFfmNT1jVXnXY6sT
	 2lRIrDkHwmsuFFKNFgsj+4RX4m6i4HSMOU1jtE6D9ul89avcSn2HsrwtChlZXJYvavYFb
	 Na9gwUEvfcCzD3tKnFlIjnHlRnCSOzRBx0fVeSOmo/Cg2f3Ewj/ZJhtJZTxsrFm/i7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793622;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vhR6IsG+Rk+VWXlr+ir06fuP3Aj8UKRDlJ6r0XXQ2X8=;
	b=YDZ+oD0QBPR2BQaeI+/LLkdPBn3E5kjI6uxT0n/AFVXKwsZg+9EyZTjA6HJQ6T6yip+U
	 0d2Ga79zZzAg29OozZXFVYR+3TZ3M8RI3MtKeulKwILAh2a9c3pDv9zjD+gsESE+y1xdx
	 9r6yDjGGOgPREd1QKBZcEBLJ9jyQu+5lSsHsV5bYDXMMjjiM/6UplNg1tfeo+nySLOBsC
	 npYN+qGzdw0NFo522HKILzr//Io8y1ey61rJcHCF4s9OjNGUOHByy07CMcjmZ74hYs9f7
	 Crui7hO0qiRvOklZy6WTz/8Xesz4EAttYg01oaN7Z/7y2E3DJac96anipMEDhQNeoDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UwsntyAk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D88606A684;
	Fri, 27 Nov 2026 15:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D88606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UwsntyAk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8980D1EA6;
	Fri, 27 Nov 2026 07:33:38 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 337853F632;
	Fri, 27 Nov 2026 07:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795793621; bh=qMOM7DQ0sgq5yTKvksMRjqHLxSAWZJcGOYDwTILlBFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UwsntyAk3EvvMQ7NNAnNwZBDAiwOohDVWpmJ/5HOTKX/HROalC3otlIErFpkfMem6
	 nLvmRYy8pRlCZkbQkbs+UxtQXDf7zW2UER+wrg99IuwcDBejTPOZxTNsZqh2REv+/1
	 11eWoPvdGGf5IvZkibe/Lep1KaiDkcqu6BBUBXRY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 27 Nov 2026 15:33:03 +0000
Subject: [PATCH RFC v3 8/8] selftest: attestation: add
 cca_guest_attestation_test selftest
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
In-Reply-To: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 thuth@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
 Pawel Chmielewski <pawel.chmielewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17380; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=qMOM7DQ0sgq5yTKvksMRjqHLxSAWZJcGOYDwTILlBFw=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBrCaK2VJe6b3BqSaIwfhduUKb/9stMF6YV1SktY
 jKzdLAm+WWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCawmitgAKCRBt1cPRWsUx
 M11gDADLkIqjnqHEbebnT6bfBEdC0jLB3YptcAD/djs4CMNe0dNZL8JXHWCgxMLNuR8BicovyWk
 vZAoPV05TFsajtlkia9me8/H1YExGNUJmNe/b7FBJPUFA+k4YOk3ww35RXskZTgH+4dt3Kxvmqj
 rp5CtDdDGhSVn3BRK8rbHZ+3sjlixIc5YBrl63QMibQBY+oUzFc9fBfPWEznnFux+tRaabE/uEl
 p1MKdfFOhK1Ka5VHNBbToqo+rM9AMH8P2Gtoxmc5PBegoIgJNWMBiLvQKFSYhfS8Wl102q+OnWZ
 fplQIocAraCvAgvbK2F8/fZus1wIn3Td5RkBd8UednDrI7Pi8+MPAAb9bcTi7L5op2jvdN4XIst
 fsJDWjmw5Agbr5xQ7ElGE9ZzyICKMwLh7zBTqAUnnVceQcZIp9ezcrKVcy/d2Q/iNbQwfQr0tQH
 2f9PP/jucGhqSxHsFQ9df/JuHMlduz/ll/fddbsNRllEHaddBCmVnQA4Av1aipT+hvLW0=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Add CCA Realm Guest attestation selftest to test evidence-get, mr_read
and mr_extend interfaces.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 tools/testing/selftests/attestation/.gitignore     |   1 +
 tools/testing/selftests/attestation/Makefile       |   9 +-
 .../attestation/cca_guest_attestation_test.c       | 517 +++++++++++++++++++++
 3 files changed, 524 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/attestation/.gitignore b/tools/testing/selftests/attestation/.gitignore
index e10d0c9e4723c..9ae9baec654d1 100644
--- a/tools/testing/selftests/attestation/.gitignore
+++ b/tools/testing/selftests/attestation/.gitignore
@@ -3,3 +3,4 @@ attestation_test
 ima_attestation_test
 tdx_attestation_test
 firme_attestation_test
+cca_guest_attestation_test
diff --git a/tools/testing/selftests/attestation/Makefile b/tools/testing/selftests/attestation/Makefile
index d4875652b4a14..f5a1ae68c0c4a 100644
--- a/tools/testing/selftests/attestation/Makefile
+++ b/tools/testing/selftests/attestation/Makefile
@@ -4,13 +4,14 @@ CFLAGS += -I../../../ctlv/libctlv
 LDLIBS += -lpthread
 
 TEST_GEN_PROGS := attestation_test ima_attestation_test tdx_attestation_test \
-		  firme_attestation_test
+		  firme_attestation_test cca_guest_attestation_test
 
 LIBCTLV_DIR := ../../../ctlv/libctlv
 BINDINGS := ctlv_attestation_user_gen.c \
 	    ctlv_attestation_sim_user_gen.c \
 	    ctlv_attestation_tdx_user_gen.c \
-	    ctlv_attestation_firme_user_gen.c
+	    ctlv_attestation_firme_user_gen.c \
+	    ctlv_attestation_cca_guest_user_gen.c
 
 EXTRA_CLEAN = $(OUTPUT)/libctlv
 
@@ -30,6 +31,9 @@ $(OUTPUT)/tdx_attestation_test: tdx_attestation_test.c $(BINDINGS) $(LIBCTLV)
 $(OUTPUT)/firme_attestation_test: firme_attestation_test.c $(BINDINGS) $(LIBCTLV)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $^ $(LDLIBS) -o $@
 
+$(OUTPUT)/cca_guest_attestation_test: cca_guest_attestation_test.c $(BINDINGS) $(LIBCTLV)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $^ $(LDLIBS) -o $@
+
 $(LIBCTLV): FORCE
 	$(Q)mkdir -p $(OUTPUT)/libctlv
 	$(Q)$(MAKE) -C $(LIBCTLV_DIR) CC="$(CC)" OUTPUT=$(OUTPUT)/libctlv/ \
@@ -38,4 +42,3 @@ $(LIBCTLV): FORCE
 FORCE:
 
 .PHONY: FORCE
-
diff --git a/tools/testing/selftests/attestation/cca_guest_attestation_test.c b/tools/testing/selftests/attestation/cca_guest_attestation_test.c
new file mode 100644
index 0000000000000..c6dc0452f79d6
--- /dev/null
+++ b/tools/testing/selftests/attestation/cca_guest_attestation_test.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/bits.h>
+#include <linux/hash_info.h>
+
+#include "../kselftest_harness.h"
+#include "ctlv_attestation_cca_guest_user_gen.h"
+
+#define EVENT_WAIT_MS 5000
+#define TDX_REPORTDATA_LEN 64
+#define TDX_REPORT_LEN 1024
+#define TDX_REPORTDATA_OFFSET 128
+#define TDX_QUOTE_MAX_LEN ((128 * 1024) - 24)
+
+static const char *error_text(const struct ctlv_error *error)
+{
+	static char text[512];
+
+	return ctlv_error_str(error, text, sizeof(text));
+}
+
+static void dump_hex(const void *data, __u64 size)
+{
+	__u64 i;
+
+	if (!TH_LOG_ENABLED)
+		return;
+
+	for (i = 0; i < size; i++) {
+		if (!(i % 16)) {
+			if (i)
+				fprintf(TH_LOG_STREAM, "\n");
+			fprintf(TH_LOG_STREAM, "\t");
+		}
+		fprintf(TH_LOG_STREAM, "%02x ", ((uint8_t *)(data))[i]);
+	}
+	fprintf(TH_LOG_STREAM, "\n");
+}
+
+static int mr_hash_info_get(struct ctlv_dev *dev, __u64 *hash_alg, size_t *digest_size)
+{
+	const struct ctlv_hdr *item, *algorithm;
+	struct ctlv_error error;
+	struct ctlv_reply *reply;
+	__u64 id, hash = HASH_ALGO__LAST;
+	int ret;
+	bool got;
+
+	ret = ctlv_attestation_mr_get(dev, NULL, &reply, &error);
+	if (ret)
+		return ret;
+
+	ret = -EIO;
+	ctlv_attestation_mr_get_items_for_each(item, ctlv_reply_root(reply)) {
+		got = ctlv_attestation_mr_get_items_id_get(item, &id);
+		if (!got)
+			goto err_out;
+		algorithm = NULL;
+		ctlv_attestation_mr_desc_supported_hash_algorithms_for_each(algorithm, item) {
+			break;
+		}
+		if (!algorithm)
+			goto err_out;
+
+		got = ctlv_attestation_mr_desc_supported_hash_algorithms_get(algorithm,
+								 	     &hash, NULL);
+		if (!got)
+			goto err_out;
+
+		break;
+	}
+
+	if (hash != HASH_ALGO_SHA256 && hash != HASH_ALGO_SHA384 &&
+	    hash != HASH_ALGO_SHA512) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	*hash_alg = hash;
+
+	if (hash == HASH_ALGO_SHA256)
+		*digest_size = 32;
+	else if (hash == HASH_ALGO_SHA384)
+		*digest_size = 48;
+	else
+		*digest_size = 64;
+
+	ret = 0;
+
+err_out:
+	ctlv_reply_free(reply);
+	return ret;
+}
+
+static int cca_guest_token_get(struct ctlv_dev *dev, __u64 id,
+			       const unsigned char *challenge, size_t challenge_length,
+			       void *output, size_t output_length,
+			       struct ctlv_reply **reply, struct ctlv_error *error)
+{
+	struct ctlv_msg *request;
+	int ret;
+
+	ret = ctlv_attestation_evidence_get_request_new(&request);
+	if (ret)
+		return ret;
+	ctlv_attestation_evidence_get_challenge_put(request, challenge,
+						    challenge_length);
+
+	ctlv_attestation_evidence_get_objects_start(request);
+	ctlv_attestation_evidence_get_objects_id_put(request, id);
+	ctlv_attestation_evidence_get_objects_data_put_va(request, output, output_length);
+	ctlv_record_end(request);
+
+	ret = ctlv_msg_err(request);
+	if (!ret)
+		ret = ctlv_attestation_evidence_get(dev, request, reply, error);
+	ctlv_msg_free(request);
+	return ret;
+}
+
+static int cca_guest_eventlog_get(struct ctlv_dev *dev, __u64 id,
+				  void *output, size_t output_length,
+				  struct ctlv_reply **reply, struct ctlv_error *error)
+{
+	struct ctlv_msg *request;
+	int ret;
+
+	if (!id)
+		return -EOPNOTSUPP;
+
+	ret = ctlv_attestation_evidence_get_request_new(&request);
+	if (ret)
+		return ret;
+
+	ctlv_attestation_evidence_get_objects_start(request);
+	ctlv_attestation_evidence_get_objects_id_put(request, id);
+	ctlv_attestation_evidence_get_objects_data_put_va(request, output, output_length);
+	ctlv_record_end(request);
+	
+	ret = ctlv_msg_err(request);
+	if (!ret)
+		ret = ctlv_attestation_evidence_get(dev, request, reply, error);
+	ctlv_msg_free(request);
+	return ret;
+}
+
+static int cca_guest_mr_read(struct ctlv_dev *dev, unsigned int id,
+			     struct ctlv_reply **reply, struct ctlv_error *error)
+{
+	struct ctlv_msg *request;
+	int ret;
+
+	ret = ctlv_attestation_mr_read_request_new(&request);
+	if (ret)
+		return ret;
+	ctlv_attestation_mr_read_id_put(request, id);
+	ret = ctlv_msg_err(request);
+	if (!ret)
+		ret = ctlv_attestation_mr_read(dev, request, reply, error);
+	ctlv_msg_free(request);
+	return ret;
+}
+
+static int cca_guest_mr_extend(struct ctlv_dev *dev, unsigned int id,
+			       const unsigned char digest[64],
+			       struct ctlv_reply **reply, struct ctlv_error *error)
+{
+	struct ctlv_msg *request;
+	__u64 hash_alg;
+	size_t digest_size;
+	int ret;
+
+	ret = mr_hash_info_get(dev, &hash_alg, &digest_size);
+	if (ret)
+		return ret;
+
+	ret = ctlv_attestation_mr_extend_request_new(&request);
+	if (ret)
+		return ret;
+
+	ctlv_attestation_mr_extend_id_put(request, id);
+	ctlv_attestation_mr_values_start(request);
+	ctlv_attestation_mr_value_hash_algo_put(request, hash_alg);
+	ctlv_attestation_mr_value_data_put(request, digest, digest_size);
+	ctlv_record_end(request);
+
+	ret = ctlv_msg_err(request);
+	if (!ret)
+		ret = ctlv_attestation_mr_extend(dev, request, reply, error);
+	ctlv_msg_free(request);
+	return ret;
+}
+
+FIXTURE(cca_guest_attestation)
+{
+	struct ctlv_dev *dev;
+	struct ctlv_error error;
+	__u64 max_challenge_size;
+	__u64 max_token_size;
+	__u64 max_eventlog_size;
+	__u64 token_id;
+	__u64 ccel_id;
+};
+
+FIXTURE_SETUP(cca_guest_attestation)
+{
+	const struct ctlv_hdr *caps, *evidence, *obj, *format, *challenge;
+	struct ctlv_reply *reply;
+	__u64 value, class;
+	__u32 obj_count = 0;
+	int ret;
+	bool got, known;
+
+	ret = ctlv_open("ctlv-attestation-cca-guest", 0, O_RDWR, &self->dev);
+	if (ret)
+		SKIP(return, "no CCA Realm guest attestation device: %s", strerror(-ret));
+
+	ASSERT_EQ(0, ctlv_attestation_device_get(self->dev, NULL, &reply,
+						 &self->error))
+	{
+		TH_LOG("%s", error_text(&self->error));
+	}
+
+	caps = ctlv_attestation_device_get_caps_get(ctlv_reply_root(reply));
+	ASSERT_NE(NULL, caps);
+
+	evidence = ctlv_attestation_device_get_caps_evidence_get(caps);
+	ASSERT_NE(NULL, evidence);
+
+	ctlv_attestation_device_get_evidence_objects_for_each(obj, evidence) {
+		obj_count++;
+	}
+
+	obj = ctlv_hdr_find(evidence, CTLV_ATTESTATION_T_DEVICE_GET_EVIDENCE_OBJECTS);
+	ASSERT_NE(NULL, obj);
+
+	got = ctlv_attestation_device_get_objects_class_get(obj, &class, &known);
+	ASSERT_TRUE(got);
+	ASSERT_EQ(class, CTLV_ATTESTATION_EVIDENCE_CLASS_SIGNED);
+
+	got = ctlv_attestation_device_get_objects_id_get(obj, &value);
+	ASSERT_TRUE(got);
+	self->token_id = value;
+	ASSERT_EQ(0, self->token_id);
+
+	got = ctlv_attestation_device_get_objects_max_length_get(obj, &value);
+	ASSERT_TRUE(got);
+	self->max_token_size = value;
+	ASSERT_NE(0, self->max_token_size);
+
+	challenge = ctlv_hdr_find(obj, CTLV_ATTESTATION_T_DEVICE_GET_OBJECTS_CHALLENGE_LENGTHS);
+	ASSERT_NE(NULL, challenge);
+
+	got = ctlv_attestation_device_get_challenge_lengths_max_length_get(challenge, &value);
+	ASSERT_TRUE(got);
+	self->max_challenge_size = value;
+	ASSERT_NE(0, self->max_challenge_size);
+
+	if (obj_count < 2) {
+		self->ccel_id = 0;
+		goto out;
+	}
+
+	obj = ctlv_hdr_find_next(evidence, obj, CTLV_ATTESTATION_T_DEVICE_GET_EVIDENCE_OBJECTS);
+	ASSERT_NE(NULL, obj);
+
+	format = ctlv_hdr_find(obj, CTLV_ATTESTATION_T_DEVICE_GET_OBJECTS_FORMATS);
+	ASSERT_NE(NULL, format);
+
+	got = ctlv_attestation_device_get_objects_formats_get(format, &value, &known);
+	ASSERT_TRUE(got);
+	ASSERT_EQ(value, CTLV_ATTESTATION_EVIDENCE_FORMAT_CCEL);
+
+	got = ctlv_attestation_device_get_objects_id_get(obj, &value);
+	ASSERT_TRUE(got);
+	self->ccel_id = value;
+
+	got = ctlv_attestation_device_get_objects_max_length_get(obj, &value);
+	ASSERT_TRUE(got);
+	self->max_eventlog_size = value;
+	ASSERT_NE(0, self->max_eventlog_size);
+
+out:
+	ctlv_reply_free(reply);
+}
+
+FIXTURE_TEARDOWN(cca_guest_attestation)
+{
+	if (self->dev)
+		ctlv_close(self->dev);
+}
+
+TEST_F(cca_guest_attestation, discovery_and_construction_fields)
+{
+	const struct ctlv_hdr *caps, *evidence, *mr, *info;
+	struct ctlv_reply *reply;
+	__u64 flags, unknown, value;
+	bool got;
+
+	EXPECT_TRUE(ctlv_dev_inherits(self->dev, "ctlv-attestation"));
+	ASSERT_EQ(0, ctlv_attestation_device_get(self->dev, NULL, &reply,
+						 &self->error))
+	{
+		TH_LOG("%s", error_text(&self->error));
+	}
+	caps = ctlv_attestation_device_get_caps_get(ctlv_reply_root(reply));
+	ASSERT_NE(NULL, caps);
+	evidence = ctlv_attestation_device_get_caps_evidence_get(caps);
+	mr = ctlv_attestation_device_get_caps_mr_get(caps);
+	ASSERT_NE(NULL, evidence);
+	ASSERT_NE(NULL, mr);
+	got = ctlv_attestation_device_get_evidence_flags_get(evidence, &flags,
+							     &unknown);
+	ASSERT_TRUE(got);
+	EXPECT_EQ(0, flags);
+	EXPECT_EQ(0, unknown);
+
+	got = ctlv_attestation_device_get_mr_flags_get(mr, &flags, &unknown);
+	ASSERT_TRUE(got);
+	EXPECT_EQ(flags, CTLV_ATTESTATION_MR_DEVICE_CAPS_EXTEND);
+	EXPECT_EQ(0, unknown);
+
+	info = ctlv_attestation_device_get_info_get(ctlv_reply_root(reply));
+	ASSERT_NE(NULL, info);
+
+	got = ctlv_attestation_cca_guest_device_info_version_get(info, &value);
+	ASSERT_TRUE(got);
+	TH_LOG("CCA Realm Guest attestation version: %lld.%lld\n",
+		(value & __GENMASK_ULL(31, 16)) >> 16,
+		value & __GENMASK_ULL(15, 0));
+
+	ctlv_reply_free(reply);
+}
+
+TEST_F(cca_guest_attestation, cca_attestation_token_get)
+{
+	void *challenge, *token;
+	struct ctlv_reply *reply;
+	const struct ctlv_hdr *root, *result;
+	unsigned int index;
+	__u64 token_size;
+	bool got;
+	int ret;
+
+	ASSERT_EQ(0, posix_memalign(&challenge, 8, self->max_challenge_size));
+	ASSERT_EQ(0, posix_memalign(&token, 8, self->max_token_size));
+
+	for (index = 0; index < self->max_challenge_size; index++)
+		((uint8_t *)challenge)[index] = index;
+
+	ret = cca_guest_token_get(self->dev, self->token_id,
+				  challenge, self->max_challenge_size,
+				  token, self->max_token_size,
+				  &reply, &self->error);
+	if (ret == -EIO || ret == -ETIMEDOUT || ret == -EOPNOTSUPP) {
+		free(token);
+		free(challenge);
+		SKIP(return, "CCA atesation token is unavailable: %s", strerror(-ret));
+	}
+
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("%s", error_text(&self->error));
+	}
+
+	root = ctlv_reply_root(reply);
+	got = ctlv_attestation_evidence_get_evidence_generation_present(root);
+	EXPECT_FALSE(got);
+
+	got = ctlv_attestation_mr_generation_present(root);
+	EXPECT_TRUE(got);
+
+	result = ctlv_hdr_find(root, CTLV_ATTESTATION_T_EVIDENCE_GET_RESULTS);
+	ASSERT_NE(NULL, result);
+
+	got = ctlv_attestation_evidence_get_results_length_get(result, &token_size);
+	ASSERT_TRUE(got);
+	ASSERT_GT(token_size, 0);
+	ASSERT_LE(token_size, self->max_token_size);
+	TH_LOG("CCA attestation token size: 0x%llx\n", token_size);
+
+	fprintf(TH_LOG_STREAM, "CCA attestation token:\n");
+	dump_hex(token, token_size);
+
+	ctlv_reply_free(reply);
+	free(token);
+	free(challenge);
+}
+
+TEST_F(cca_guest_attestation, cca_eventlog_get)
+{
+	void *eventlog;
+	struct ctlv_reply *reply;
+	const struct ctlv_hdr *root, *result;
+	__u64 log_size;
+	bool got;
+	int ret;
+
+	ASSERT_EQ(0, posix_memalign(&eventlog, 8, self->max_eventlog_size));
+
+	ret = cca_guest_eventlog_get(self->dev, self->ccel_id,
+				     eventlog, self->max_eventlog_size,
+				     &reply, &self->error);
+	if (ret == -EIO || ret == -ETIMEDOUT || ret == -EOPNOTSUPP) {
+		free(eventlog);
+		SKIP(return, "CCA eventlog is unavailable: %s", strerror(-ret));
+	}
+
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("%s", error_text(&self->error));
+	}
+
+	root = ctlv_reply_root(reply);
+	got = ctlv_attestation_evidence_get_evidence_generation_present(root);
+	EXPECT_FALSE(got);
+
+	result = ctlv_hdr_find(root, CTLV_ATTESTATION_T_EVIDENCE_GET_RESULTS);
+	ASSERT_NE(NULL, result);
+
+	got = ctlv_attestation_evidence_get_results_length_get(result, &log_size);
+	ASSERT_TRUE(got);
+	ASSERT_GT(log_size, 0);
+	ASSERT_LE(log_size, self->max_eventlog_size);
+	TH_LOG("CCA attestation eventlog size: 0x%llx\n", log_size);
+
+	fprintf(TH_LOG_STREAM, "CCA attestation eventlog:\n");
+	dump_hex(eventlog, log_size);
+
+	ctlv_reply_free(reply);
+	free(eventlog);
+}
+
+TEST_F(cca_guest_attestation, read_measurement_registers)
+{
+	const struct ctlv_hdr *item, *algorithm, *value;
+	struct ctlv_reply *reply;
+	const void *digest;
+	__u64 id, hash = HASH_ALGO__LAST;
+	__u32 length;
+	unsigned int count = 0;
+	bool got;
+
+	ASSERT_EQ(0, ctlv_attestation_mr_get(self->dev, NULL, &reply,
+					     &self->error));
+	ctlv_attestation_mr_get_items_for_each(item, ctlv_reply_root(reply)) {
+		ASSERT_TRUE(ctlv_attestation_mr_get_items_id_get(item, &id));
+		EXPECT_EQ(count, id);
+		algorithm = NULL;
+		ctlv_attestation_mr_desc_supported_hash_algorithms_for_each(algorithm, item) {
+			break;
+		}
+		ASSERT_NE(NULL, algorithm);
+		got = ctlv_attestation_mr_desc_supported_hash_algorithms_get(algorithm,
+									     &hash, NULL);
+		ASSERT_TRUE(got);
+		count++;
+	}
+	ASSERT_EQ(5, count);
+	ASSERT_TRUE(hash == HASH_ALGO_SHA256 || hash == HASH_ALGO_SHA384 ||
+		    hash == HASH_ALGO_SHA512);
+	ctlv_reply_free(reply);
+
+	for (id = 0; id < 5; id++) {
+		ASSERT_EQ(0, cca_guest_mr_read(self->dev, id, &reply, &self->error));
+		value = NULL;
+		ctlv_attestation_mr_values_for_each(value, ctlv_reply_root(reply)) {
+			break;
+		}
+		ASSERT_NE(NULL, value);
+		got = ctlv_attestation_mr_value_data_get(value, &digest, &length);
+		ASSERT_TRUE(got);
+		if (hash == HASH_ALGO_SHA256) {
+			EXPECT_EQ(32, length);
+		} else if (hash == HASH_ALGO_SHA384) {
+			EXPECT_EQ(48, length);
+		} else {
+			EXPECT_EQ(64, length);
+		}
+
+		fprintf(TH_LOG_STREAM, "mr_id(%llu):\n", id);
+		dump_hex(digest, length);
+
+		ctlv_reply_free(reply);
+	}
+}
+
+TEST_F(cca_guest_attestation, extend_measurment_registers)
+{
+	const __u64 subscriptions[] = {
+		CTLV_ATTESTATION_OP_MR_LOG_ENTRY_APPENDED,
+	};
+	unsigned char digest[64] = { 0xa5 };
+	struct ctlv_event *event;
+	struct ctlv_reply *reply;
+	unsigned long id;
+
+	ASSERT_EQ(0, ctlv_subscribe(self->dev, subscriptions,
+				    ARRAY_SIZE(subscriptions), &self->error));
+
+	for (id = 1; id < 5; id++) {
+		ASSERT_EQ(0, cca_guest_mr_extend(self->dev, id, digest,
+						 &reply, &self->error));
+		ctlv_reply_free(reply);
+		ASSERT_EQ(0, ctlv_event_wait(self->dev, EVENT_WAIT_MS));
+		ASSERT_EQ(0, ctlv_event_read(self->dev, &event));
+		EXPECT_TRUE(ctlv_attestation_mr_log_entry_appended_is(event));
+		ctlv_event_free(event);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.43.0

