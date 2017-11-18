From: davem@davemloft.net (David Miller)
Date: Sat, 18 Nov 2017 10:35:36 +0900 (KST)
Subject: [PATCH] net/netlabel: Add list_next_rcu() in rcu_dereference().
In-Reply-To: <20171116170334.GA141280@debian>
References: <20171116170334.GA141280@debian>
Message-ID: <20171118.103536.965800271330929492.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Tim Hansen <devtimhansen@gmail.com>
Date: Thu, 16 Nov 2017 12:03:34 -0500

> Add list_next_rcu() for fetching next list in rcu_deference safely.
> 
> Found with sparse in linux-next tree on tag next-20171116.
> 
> Signed-off-by: Tim Hansen <devtimhansen@gmail.com>

Applied.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
