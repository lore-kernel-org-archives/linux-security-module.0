From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Fri,  7 Apr 2017 17:57:05 -0700
Subject: [PATCH 07/12] fs: btrfs: Use ktime_get_real_ts for root ctime
In-Reply-To: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
Message-ID: <1491613030-11599-8-git-send-email-deepa.kernel@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

btrfs_root_item maintains the ctime for root updates.
This is not part of vfs_inode.

Since current_time() uses struct inode* as an argument
as Linus suggested, this cannot be used to update root
times unless, we modify the signature to use inode.

Since btrfs uses nanosecond time granularity, it can also
use ktime_get_real_ts directly to obtain timestamp for
the root. It is necessary to use the timespec time api
here because the same btrfs_set_stack_timespec_*() apis
are used for vfs inode times as well. These can be
transitioned to using timespec64 when btrfs internally
changes to use timespec64 as well.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/root-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index a08224e..7d6bc30 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -501,8 +501,9 @@ void btrfs_update_root_times(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root)
 {
 	struct btrfs_root_item *item = &root->root_item;
-	struct timespec ct = current_fs_time(root->fs_info->sb);
+	struct timespec ct;
 
+	ktime_get_real_ts(&ct);
 	spin_lock(&root->root_item_lock);
 	btrfs_set_root_ctransid(item, trans->transid);
 	btrfs_set_stack_timespec_sec(&item->ctime, ct.tv_sec);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
