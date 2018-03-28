From: dave@stgolabs.net (Davidlohr Bueso)
Date: Wed, 28 Mar 2018 16:57:59 -0700
Subject: [REVIEW][PATCH 13/11] ipc/smack: Tidy up from the change in type
	of the ipc security hooks
In-Reply-To: <87y3iikp1y.fsf_-_@xmission.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
	<87vadzqqq6.fsf@xmission.com>
	<990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
	<877eqejowd.fsf@xmission.com>
	<3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
	<87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
	<87y3iikp1y.fsf_-_@xmission.com>
Message-ID: <20180328235759.fmnldverphwzq5rt@linux-n805>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 24 Mar 2018, Eric W. Biederman wrote:

> /**
>- * smack_of_shm - the smack pointer for the shm
>- * @shp: the object
>+ * smack_of_ipc - the smack pointer for the ipc
>+ * @isp: the object

Nit, but while at it the @isp description does need some love:

"@isp: the pointer for the ipc perm structure"
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
