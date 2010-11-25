CREATE TABLE `asset_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_campaign_id` int(11) DEFAULT NULL,
  `asset_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_file_size` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bar_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `origin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` mediumtext COLLATE utf8_unicode_ci,
  `version` int(11) DEFAULT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bar_codes_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'unpublished',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `display` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cities_on_region_id` (`region_id`),
  KEY `index_cities_on_country_id` (`country_id`),
  KEY `index_cities_on_name` (`name`),
  KEY `index_cities_on_name_and_country_id_and_region_id` (`name`,`country_id`,`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `referer` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent_id` int(11) NOT NULL DEFAULT '1',
  `short_url_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `located` tinyint(1) DEFAULT '0',
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_clicks_on_short_url_id` (`short_url_id`),
  KEY `index_clicks_on_user_agent_id` (`user_agent_id`),
  KEY `index_clicks_on_short_url_id_and_created_at` (`short_url_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `display` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_countries_on_name` (`name`),
  KEY `index_countries_on_code` (`code`),
  KEY `index_countries_on_name_and_code` (`name`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `mobile_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `style_model` text COLLATE utf8_unicode_ci,
  `document_model` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `current_state` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'published',
  `short_url_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mobile_campaigns_on_current_state` (`current_state`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `mobiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resolution` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int(11) DEFAULT '0',
  `height` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_regions_on_code` (`code`),
  KEY `index_regions_on_name` (`name`),
  KEY `index_regions_on_country_id` (`country_id`),
  KEY `index_regions_on_code_and_country_id` (`code`,`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `short_sequences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `short_urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `short` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `clicks_count` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `current_state` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'proxied',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_short_urls_on_short` (`short`),
  KEY `index_short_urls_on_current_state` (`current_state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `summarized_clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clicks` int(11) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `short_url_id` int(11) NOT NULL,
  `percent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_summarized_clicks_on_short_url_id` (`short_url_id`),
  KEY `index_summarized_clicks_on_short_url_id_and_date` (`short_url_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `user_agents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20100430172227');

INSERT INTO schema_migrations (version) VALUES ('20100501201745');

INSERT INTO schema_migrations (version) VALUES ('20100503140340');

INSERT INTO schema_migrations (version) VALUES ('20100503141450');

INSERT INTO schema_migrations (version) VALUES ('20100504172103');

INSERT INTO schema_migrations (version) VALUES ('20100512175856');

INSERT INTO schema_migrations (version) VALUES ('20100517165032');

INSERT INTO schema_migrations (version) VALUES ('20100628161310');

INSERT INTO schema_migrations (version) VALUES ('20100903092532');

INSERT INTO schema_migrations (version) VALUES ('20100923145735');

INSERT INTO schema_migrations (version) VALUES ('20100923150606');

INSERT INTO schema_migrations (version) VALUES ('20101005090024');

INSERT INTO schema_migrations (version) VALUES ('20101117164536');

INSERT INTO schema_migrations (version) VALUES ('20101122194643');

INSERT INTO schema_migrations (version) VALUES ('20101122204544');

INSERT INTO schema_migrations (version) VALUES ('20101122221155');

INSERT INTO schema_migrations (version) VALUES ('20101124155451');