From: tomas.winkler@intel.com (Tomas Winkler)
Date: Sat, 10 Mar 2018 10:24:28 +0200
Subject: [PATCH v2 8/8] tpm: move tpm2 code validation to tpm2-space.c
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Message-ID: <20180310082428.31519-9-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add new function tpm2_validate_command to tpm2-space.c
that wraps up open coded functionality from tpm_validate_command.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 31 ++-----------------------------
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm2-cmd.c      |  1 +
 drivers/char/tpm/tpm2-space.c    | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index d347ad8325c6..93f7c12d4c4d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -52,40 +52,13 @@ static int tpm_validate_command(struct tpm_chip *chip,
 				 const u8 *cmd,
 				 size_t len)
 {
-	const struct tpm_input_header *header = (const void *)cmd;
-	int i;
-	u32 cc;
-	u32 attrs;
-	unsigned int nr_handles;
-
 	if (len < TPM_HEADER_SIZE)
 		return -EINVAL;
 
-	if (!space)
-		return 0;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
-		cc = be32_to_cpu(header->ordinal);
-
-		i = tpm2_find_cc(chip, cc);
-		if (i < 0) {
-			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
-				cc);
-			return -EOPNOTSUPP;
-		}
-
-		attrs = chip->cc_attrs_tbl[i];
-		nr_handles =
-			4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0));
-		if (len < TPM_HEADER_SIZE + 4 * nr_handles)
-			goto err_len;
-	}
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 && space)
+		return tpm2_validate_command(chip, cmd, len);
 
 	return 0;
-err_len:
-	dev_dbg(&chip->dev,
-		"%s: insufficient command length %zu", __func__, len);
-	return -EINVAL;
 }
 
 static int tpm_request_locality(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2b88aadc4743..15453a78a0d0 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -602,6 +602,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 		       u8 *cmd);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 		      u32 cc, u8 *buf, size_t *bufsiz);
+int tpm2_validate_command(struct tpm_chip *chip, const u8 *cmd, size_t len);
 
 extern const struct seq_operations tpm2_binary_b_measurements_seqops;
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 80eb4bb5feef..6db13cf801b4 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -1112,3 +1112,4 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 4e4014eabdb9..ed9eff948c05 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -263,6 +263,38 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
 	return 0;
 }
 
+int tpm2_validate_command(struct tpm_chip *chip, const u8 *cmd, size_t len)
+{
+	int i;
+	u32 cc;
+	u32 attrs;
+	unsigned int nr_handles;
+
+	if (len < TPM_HEADER_SIZE)
+		return -EINVAL;
+
+	if (!chip->nr_commands)
+		return 0;
+
+	cc =  be32_to_cpup((__be32 *)(cmd + 6));
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0) {
+		dev_dbg(&chip->dev, "0x%04X is an invalid command\n", cc);
+		return -EOPNOTSUPP;
+	}
+
+	attrs = chip->cc_attrs_tbl[i];
+	nr_handles = 4 * ((attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0));
+	if (len < TPM_HEADER_SIZE + 4 * nr_handles) {
+		dev_dbg(&chip->dev,
+			"%s: insufficient command length %zu", __func__, len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 		       u8 *cmd)
 {
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
