Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FD314A90;
	Fri, 22 May 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417184; cv=none; b=T1kBSL6qVyqEtI/ExD5X0XfYcqP+GWFn/2oHf50QSCeOn4DRlAIbWIbpyiMxPKw/JmaSi1qjjaiSLFR88ZGnvb57Dueg7mYS2ZxAmnAkBbKq4366VRQsIgofRwJgAkRdIIXA6SlYInPSJkEUMjgMGTdp9bLef7O+S1KkyqAg2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417184; c=relaxed/simple;
	bh=YpX0IuU6uad++fQtai4BUCTVNCZue4EbKyrGLOL+2gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnQa9kONbvHIDnQ1reoi1EsHIcirQul9iQbQ3IxhmDqwiOImkQfLBy08M/ka4++jht3n+uAERW1DuR2rCSajTt6S9VkGz/N60I1HpAIueuCdfmc6oF+UWXbHzJ4yNmz9i/8NWfP2Xt189F8Cbk4yC9UU7rN2FEZAnQLQfWzyZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWqDWNW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWqDWNW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9011F00A3D;
	Fri, 22 May 2026 02:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417183;
	bh=E3TmmLfniL0rHf0KLHL+HUN0NFX4Y12fyjg3C7NkEpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWqDWNW62T8VQBlZWXGQpzzfU1dInbAlq1ZLjPfErRYlaB1z23F8IQViDKDJLEgbu
	 duIC0oypZgmquAwK6q9ZjT4iMNe+AQxWuA5dZFko2saVG2N+3aKKNfaTK58qmDzAjU
	 bgqC6+9qT4wV+vfyJ/WQFDtR1cBR80jVvkTyTUXbDrF1/FVqXHXH0jHmvm6wYotNc7
	 +4Pe4YtMDWwlDAFrWtY/m1Uky4J0k1EvXPu131fCmbcHAc68tFUwjDLPMORz2GnRMb
	 fktw3hODnj6OrWjv5Ogj/GLyF/oVDn037eo4dhIqC9zoKh1zjspMYv/1XmDcEOcM43
	 tNwrj8kvCcrpw==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 13/13] selftests/bpf: add IPE BPF policy integration tests
Date: Fri, 22 May 2026 04:32:33 +0200
Message-ID: <20260522023234.3778588-14-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smoke test for the IPE BPF signing properties and ops added in the
preceding patches. The test primes the kernel config with IPE
knobs, writes a boot policy, and boots vmtest.sh to verify that
signed lskels load, unsigned loads are denied, and the policy
audit lines match.

Manual only for now, not wired into the selftests Makefile.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../selftests/bpf/test_signed_bpf_ipe.sh      | 156 ++++++++++++++++++
 tools/testing/selftests/bpf/vmtest.sh         |   4 +-
 2 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/test_signed_bpf_ipe.sh

diff --git a/tools/testing/selftests/bpf/test_signed_bpf_ipe.sh b/tools/testing/selftests/bpf/test_signed_bpf_ipe.sh
new file mode 100755
index 000000000000..aaa259ddb917
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_signed_bpf_ipe.sh
@@ -0,0 +1,156 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# IPE BPF policy integration tests.
+
+if [ "${1:-}" = "--in-vm" ]; then
+	set -u
+	fail=0
+	record() {
+		id=$1; verdict=$2; shift 2
+		printf '%s %s %s\n' "$verdict" "$id" "$*"
+		[ "$verdict" = FAIL ] && fail=$((fail + 1))
+		return 0
+	}
+
+	mountpoint -q /sys/kernel/security 2>/dev/null \
+		|| mount -t securityfs none /sys/kernel/security 2>/dev/null || true
+	if [ -d /sys/kernel/security/ipe ]; then
+		record T0 PASS "securityfs/ipe present"
+	elif grep -qw ipe /sys/kernel/security/lsm 2>/dev/null; then
+		record T0 PASS "ipe in /sys/kernel/security/lsm"
+	elif [ -r /sys/module/ipe/parameters/enforce ]; then
+		record T0 PASS "ipe module parameters present"
+	else
+		record T0 FAIL "no sign that IPE LSM is loaded"
+	fi
+
+	if ./test_progs -t atomics 2>&1 | grep -qE '^#[0-9]+[[:space:]]+atomics:OK$'; then
+		record T1 PASS "atomics signed lskel loaded"
+	else
+		record T1 FAIL "atomics signed lskel did not load"
+	fi
+
+	if dmesg | grep -q 'ipe_op=BPF_PROG_LOAD ipe_hook=BPF_PROG_LOAD'; then
+		record T2 PASS "ipe_op=BPF_PROG_LOAD audit line found"
+	else
+		record T2 FAIL "no ipe_op=BPF_PROG_LOAD audit lines in dmesg"
+	fi
+
+	if dmesg | grep 'ipe_op=BPF_PROG_LOAD' \
+		| grep -q 'bpf_signature=UNSIGNED action=DENY'; then
+		record T3 PASS "deny-UNSIGNED rule matched"
+	else
+		record T3 FAIL "deny-UNSIGNED rule never matched"
+	fi
+
+	mountpoint -q /sys/kernel/security 2>/dev/null \
+		|| mount -t securityfs none /sys/kernel/security 2>/dev/null || true
+	content=
+	for d in /sys/kernel/security/ipe/policies/*/; do
+		[ -d "$d" ] || continue
+		if [ -r "$d/policy" ]; then
+			content=$(cat "$d/policy" 2>/dev/null || true)
+			break
+		fi
+	done
+	if [ -z "$content" ]; then
+		record T5 SKIP "could not read /sys/kernel/security/ipe/policies/*/policy"
+	elif echo "$content" | grep -q '^op=BPF_PROG_LOAD_POST_INTEGRITY'; then
+		record T5 PASS "post-integrity rule present in active policy"
+	else
+		record T5 FAIL "active policy does not contain a BPF_PROG_LOAD_POST_INTEGRITY rule"
+	fi
+
+	ENFORCE=/sys/kernel/security/ipe/enforce
+	mountpoint -q /sys/kernel/security 2>/dev/null \
+		|| mount -t securityfs none /sys/kernel/security 2>/dev/null || true
+
+	if [ ! -w "$ENFORCE" ]; then
+		record T4 SKIP "$ENFORCE not writable"
+	elif ! echo 1 > "$ENFORCE" 2>/dev/null; then
+		record T4 SKIP "could not toggle IPE to enforce=1"
+	else
+		out=$(./test_progs -t bind_perm 2>&1 || true)
+		if echo "$out" | grep -q -- '-EACCES\|errno 13'; then
+			record T4 PASS "unsigned load denied with -EACCES under enforce=1"
+		else
+			record T4 FAIL "no -EACCES seen from unsigned load under enforce=1"
+			echo "$out" | tail -10 | sed 's/^/  T4: /'
+		fi
+		echo 0 > "$ENFORCE" 2>/dev/null || true
+	fi
+
+	if [ "$fail" -eq 0 ]; then
+		echo ALL_TESTS_PASSED
+	else
+		echo FAIL_COUNT "$fail"
+	fi
+	exit 0
+fi
+
+set -euo pipefail
+
+SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
+KERNEL_DIR=$(cd "$SCRIPT_DIR/../../../.." && pwd)
+VMTEST="$SCRIPT_DIR/vmtest.sh"
+
+POLICY_PATH=${IPE_TEST_POLICY:-/tmp/ipe_bpf_test_policy}
+
+red()   { printf '\033[31m%s\033[0m\n' "$*"; }
+green() { printf '\033[32m%s\033[0m\n' "$*"; }
+bold()  { printf '\033[1m%s\033[0m\n' "$*"; }
+
+bold "=== IPE BPF policy integration tests ==="
+
+tmpfile=$(mktemp -p "$(dirname "$POLICY_PATH")" \
+		  ".$(basename "$POLICY_PATH").XXXXXX")
+cat > "$tmpfile" <<EOF
+policy_name="ipe_bpf_test" policy_version=0.0.1
+op=BPF_PROG_LOAD bpf_signature=OK                action=ALLOW
+op=BPF_PROG_LOAD bpf_signature=UNSIGNED          action=DENY
+op=BPF_PROG_LOAD_POST_INTEGRITY                  action=ALLOW
+DEFAULT op=BPF_PROG_LOAD                         action=ALLOW
+DEFAULT op=BPF_PROG_LOAD_POST_INTEGRITY          action=ALLOW
+DEFAULT action=ALLOW
+EOF
+mv "$tmpfile" "$POLICY_PATH"
+echo "policy written to $POLICY_PATH"
+
+export OUTPUT_DIR=${OUTPUT_DIR:-$HOME/.bpf_selftests_ipe}
+CFG="$OUTPUT_DIR/latest.config"
+mkdir -p "$OUTPUT_DIR"
+if [ ! -f "$CFG" ]; then
+	PLATFORM=$(uname -m)
+	for src in "$KERNEL_DIR/tools/testing/selftests/bpf/config" \
+		   "$KERNEL_DIR/tools/testing/selftests/bpf/config.vm" \
+		   "$KERNEL_DIR/tools/testing/selftests/bpf/config.$PLATFORM"; do
+		[ -f "$src" ] && cat "$src" >> "$CFG"
+	done
+fi
+"$KERNEL_DIR/scripts/config" --file "$CFG" \
+	--enable SECURITY_IPE \
+	--enable IPE_PROP_BPF_SIGNATURE \
+	--set-str IPE_BOOT_POLICY "$POLICY_PATH"
+lsm=$("$KERNEL_DIR/scripts/config" --file "$CFG" --state LSM 2>/dev/null)
+if [ -z "$lsm" ] || [ "$lsm" = "undef" ]; then
+	"$KERNEL_DIR/scripts/config" --file "$CFG" --set-str LSM "bpf,ipe"
+elif ! echo ",${lsm}," | grep -q ',ipe,'; then
+	"$KERNEL_DIR/scripts/config" --file "$CFG" --set-str LSM "${lsm},ipe"
+fi
+touch "$CFG"
+
+RUN_OUT=$(mktemp -t ipe_test_run.XXXXXX)
+trap 'rm -f "$RUN_OUT"' EXIT
+export VMTEST_EXTRA_CMDLINE="ipe.enforce=0 ipe.success_audit=1"
+"$VMTEST" -- ./test_signed_bpf_ipe.sh --in-vm 2>&1 | tee "$RUN_OUT"
+
+if grep -q 'ALL_TESTS_PASSED' "$RUN_OUT"; then
+	green "=== all IPE policy integration tests PASSED ==="
+	grep -E '^(PASS|FAIL|SKIP) T[0-9]+' "$RUN_OUT" || true
+	exit 0
+else
+	red "=== IPE policy integration tests FAILED ==="
+	grep -E '^(PASS|FAIL|SKIP) T[0-9]+' "$RUN_OUT" || true
+	exit 1
+fi
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 2f869daf8a06..b30e2b359413 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -61,7 +61,7 @@ DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
 LOCAL_ROOTFS_IMAGE=""
 ROOTFS_IMAGE="root.img"
-OUTPUT_DIR="$HOME/.bpf_selftests"
+OUTPUT_DIR="${OUTPUT_DIR:-$HOME/.bpf_selftests}"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
 	"tools/testing/selftests/bpf/config.${PLATFORM}")
@@ -294,7 +294,7 @@ EOF
 		-m 4G \
 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
 		-kernel "${kernel_bzimage}" \
-		-append "root=/dev/vda rw console=${QEMU_CONSOLE}"
+		-append "root=/dev/vda rw console=${QEMU_CONSOLE} ${VMTEST_EXTRA_CMDLINE:-}"
 }
 
 copy_logs()
-- 
2.53.0

