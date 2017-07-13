From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 13 Jul 2017 16:21:11 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
References: <1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
Message-ID: <20170713212111.GC6167@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> For virtualizing the xattrs on the 'value' side I was looking for
> whether there's something like a 'wrapper' structure around the
> actual value of the xattr so that that wrapper could be extended to
> support different values at different uids and applied to any xattr.
> Unfortunately there's no such 'wrapper'.

I believe my very first implementation did essentially this - it used
the not uncommon structure of (mostly making this up):

struct ns_vfs_cap {
	int magic;
	int ncaps;
	struct ns_vfs_cap_data data[0];
};

with (ncaps * sizeof(ns_vfs_cap_data)) following that.

I didn't like it.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
